import 'package:farma_compara/core/either.dart';
import 'package:farma_compara/domain/delivery/delivery_failure.dart';
import 'package:farma_compara/domain/delivery/delivery_fees.dart';
import 'package:farma_compara/domain/items/item_cart.dart';
import 'package:farma_compara/domain/items/payment_optimized/algorithm/payment_optimized_strategy.dart';
import 'package:farma_compara/domain/items/payment_optimized/payment_optimized.dart';

import '../../../core/utils.dart';

class PaymentOptimizedBestPriceOrAdjacent extends PaymentOptimizedStrategy {


  @override
  Either<ItemsDeliveryFailure, PaymentOptimized>? paymentFromCart(
      {required DeliveryFees deliveryFees, required String location, required List<ItemCart> inputItems}) {

    if (deliveryFees.deliveryFeeMap.isEmpty) {
      return null;
    }

    Map<String, PaymentShop> paymentShops = {};

    final List<ItemCart> items = (Utils.deepCopy(inputItems) as List<dynamic>).cast<ItemCart>();

    final emptyList = List<ItemDeliveryFailure>.empty(growable: true);
    final ItemsDeliveryFailure itemsDeliveryFailure = ItemsDeliveryFailure(items: emptyList, location: location);
// Filter unavailable shops and items whose location cannot be used


    removeNotAvailableItems(items, deliveryFees, itemsDeliveryFailure, location);

    if (itemsDeliveryFailure.hasFailure()) {
      return Left(itemsDeliveryFailure);
    }

// Add items with 1 website first
    addItemsSingleLocation(items, deliveryFees, paymentShops);

// Add items with more than 1 website

    final List<ItemCart> itemsWithMoreThanOneWebsite =
        items.where((element) => element.item.websiteItems.length > 1).toList();
    if (items.isEmpty) {
      final PaymentOptimized paymentOptimized = PaymentOptimized(shopsToPay: paymentShops, location: location);
      return Right(paymentOptimized);
    }

    final List<Map<String, PaymentShop>> paymentShopOptions = [];

// By product price
    _addOptionsByProductPrice(itemsWithMoreThanOneWebsite, deliveryFees, paymentShops, paymentShopOptions);
    _addOptionsByProductPrice(itemsWithMoreThanOneWebsite, deliveryFees, paymentShops, paymentShopOptions, 1);

// Check all options and select the best one
    PaymentOptimized? bestOption;
    double bestPrice = double.maxFinite;

    bestOption = getBestPaymentOptimized(paymentShopOptions, location, bestPrice, bestOption);

    return Right(bestOption!);
  }



  void _addOptionsByProductPrice(List<ItemCart> items, DeliveryFees deliveryFees, Map<String, PaymentShop> paymentShops,
      List<Map<String, PaymentShop>> paymentShopOptions,
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

        addItemByKey(deliveryFees, key, paymentShopsCopy, cartItem);
      }
      paymentShopOptions.add(paymentShopsCopy);
    }
  }




}
