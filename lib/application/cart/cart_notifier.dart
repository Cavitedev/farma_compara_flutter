import 'package:farma_compara_flutter/application/cart/cart_state.dart';
import 'package:farma_compara_flutter/core/either.dart';
import 'package:farma_compara_flutter/domain/core/utils.dart';
import 'package:farma_compara_flutter/domain/delivery/delivery_failure.dart';
import 'package:farma_compara_flutter/domain/delivery/delivery_fee.dart';
import 'package:farma_compara_flutter/domain/delivery/delivery_fees.dart';
import 'package:farma_compara_flutter/domain/delivery/i_delivery_repository.dart';
import 'package:farma_compara_flutter/domain/core/firestore_failure.dart';
import 'package:farma_compara_flutter/domain/items/item_cart.dart';
import 'package:farma_compara_flutter/domain/items/payment_optimized/payment_optimized.dart';
import 'package:farma_compara_flutter/domain/items/shop_item.dart';
import 'package:farma_compara_flutter/infrastructure/firebase/delivery/delivery_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/optional.dart';
import '../../domain/items/item.dart';

final cartNotifierProvider =
    StateNotifierProvider<CartNotifier, CartState>((ref) => CartNotifier(ref.read(deliveryRepositoryProvider)));

class CartNotifier extends StateNotifier<CartState> {
  CartNotifier(this.repository) : super(CartState.init());

  IDeliveryRepository repository;

  Future<void> loadDeliveryFees() async {
    state = state.copyWith(isLoading: true);
    final Either<FirestoreFailure, Map<String, DeliveryFee>> deliveryEither = await repository.updateDelivery();

    deliveryEither.when(
      (left) => state = state.copyWith(failure: Optional.value(left), isLoading: false),
      (right) {
        Map<String, DeliveryFee> deliveryFees = right;
        state = state.copyWith(
            deliveryFees: DeliveryFees(deliveryFeeMap: deliveryFees), failure: const Optional(), isLoading: false);
        calculateOptimizedPrices();
      },
    );
  }

  void addItem(Item item) {
    state = state.addItem(item);
    calculateOptimizedPrices();
  }

  void removeItem(Item item) {
    state = state.removeItem(item);
    calculateOptimizedPrices();
  }

  void updateLocation(String location) {
    state = state.copyWith(location: location);
    calculateOptimizedPrices();
  }

  void calculateOptimizedPrices() {

    if(state.deliveryFees.deliveryFeeMap.isEmpty) {
      return;
    }

    final String location = state.location;
    Map<String, PaymentShop> paymentShops = {};

    final List<ItemCart> items = (Utils.deepCopy(state.items) as List<dynamic>).cast<ItemCart>();

    final emptyList = List<ItemDeliveryFailure>.empty(growable: true);
    final ItemsDeliveryFailure itemsDeliveryFailure = ItemsDeliveryFailure(items: emptyList, location: location);
    // Filter unavailable shops and items whose location cannot be used

    _removeNotAvailableItems(items, itemsDeliveryFailure, location);

    if (itemsDeliveryFailure.hasFailure()) {
      state = state.copyWith(paymentOptimized:  Left(itemsDeliveryFailure));
      return;
    }

    // Add items with 1 website first
    _addItemsSingleLocation(items, paymentShops);

    // Add items with more than 1 website

    final List<ItemCart> itemsWithMoreThanOneWebsite =
        items.where((element) => element.item.websiteItems.length > 1).toList();
    if (items.isEmpty) {
      final PaymentOptimized paymentOptimized = PaymentOptimized(shopsToPay: paymentShops, location: location);
      state = state.copyWith(paymentOptimized: Right(paymentOptimized));
      return;
    }

    final List<Map<String, PaymentShop>> paymentShopOptions = [];

    // By product price
    _addOptionsByProductPrice(itemsWithMoreThanOneWebsite, paymentShops, paymentShopOptions);
    _addOptionsByProductPrice(itemsWithMoreThanOneWebsite, paymentShops, paymentShopOptions, 1);

    // Check all options and select the best one
    PaymentOptimized? bestOption;
    double bestPrice = double.maxFinite;

    for (final option in paymentShopOptions) {
      final payOption = PaymentOptimized(shopsToPay: option, location: location);
      double price = payOption.total().getRight()!.totalPrice;

      if (price < bestPrice) {
        bestOption = payOption;
        bestPrice = price;
      }
    }

    state = state.copyWith(paymentOptimized: Right(bestOption!));
  }

  void _removeNotAvailableItems(List<ItemCart> items, ItemsDeliveryFailure itemsFailure, String location) {
    for (int i = 0; i < items.length; i++) {
      final cartItem = items[i];
      Map<String, ShopItem> filteredWebsiteItems = {};

      final ItemDeliveryFailure itemfailure = ItemDeliveryFailure(item: cartItem.item, websites: []);

      for (final websiteItem in cartItem.item.websiteItems.entries) {
        final fee = state.deliveryFees.deliveryFeeMap[websiteItem.key]!;

        if (!websiteItem.value.available) {
          const DeliveryFailure failure = DeliveryFailureNotAvailable();
          final webFailure = WebsiteDeliveryFailure(website: websiteItem.key, failure: failure);
          itemfailure.websites.add(webFailure);
        } else if (!fee.canBeDeliveredIn(location)) {
          final DeliveryFailure failure = DeliveryFailureNotFound(location: location);
          final WebsiteDeliveryFailure webFailure = WebsiteDeliveryFailure(website: websiteItem.key, failure: failure);
          itemfailure.websites.add(webFailure);
        } else {
          filteredWebsiteItems[websiteItem.key] = websiteItem.value;
        }
      }
      if (filteredWebsiteItems.isEmpty) {
        itemsFailure.items.add(itemfailure);
      }

      items[i] = cartItem.copyWith(item: cartItem.item.copyWith(websiteItems: filteredWebsiteItems));
    }
  }

  void _addOptionsByProductPrice(
      List<ItemCart> items, Map<String, PaymentShop> paymentShops, List<Map<String, PaymentShop>> paymentShopOptions,
      [int exceptions = 0]) {
    final int combinations = exceptions == 0 ? 1 : items.length;

    for (int it = 0; it < combinations; it++) {
      final Map<String, PaymentShop> paymentShopsCopy =
          Map.castFrom<dynamic, dynamic, String, PaymentShop>(Utils.deepCopy(paymentShops));

      final List<int> exceptionsList = exceptions == 0 ? [] : [it];

      for (int i = 0; i < items.length; i++) {
        final cartItem = items[i];
        final pagesList = cartItem.item.orderedWebsiteItemsByPrice();
        String key;

        if (exceptionsList.contains(i)) {
          key = pagesList[1].key;
        } else {
          key = pagesList[0].key;
        }

        _addItemByKey(key, paymentShopsCopy, cartItem);
      }
      paymentShopOptions.add(paymentShopsCopy);
    }
  }

  void _addItemByKey(String key, Map<String, PaymentShop> paymentShops, ItemCart cartItem) {
    final DeliveryFee fee = state.deliveryFees.deliveryFeeMap[key]!;

    if (paymentShops.containsKey(key)) {
      paymentShops[key]!.items.add(cartItem);
    } else {
      final PaymentShop paymentShop = PaymentShop(shopName: key, fee: fee, items: [cartItem]);
      paymentShops[key] = paymentShop;
    }
  }

  void _addItemsSingleLocation(List<ItemCart> items, Map<String, PaymentShop> paymentShops) {
    for (final cartItem in items) {
      if (cartItem.item.websiteItems.length == 1) {
        final String key = cartItem.item.websiteItems.keys.first;
        _addItemByKey(key, paymentShops, cartItem);
      }
    }
  }
}
