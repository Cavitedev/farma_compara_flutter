import 'package:farma_compara/domain/items/payment_optimized/algorithm/payment_optimized_strategy.dart';

import '../../../../core/either.dart';
import '../../../core/utils.dart';
import '../../../delivery/delivery_failure.dart';
import '../../../delivery/delivery_fees.dart';
import '../../item_cart.dart';
import '../payment_optimized.dart';

class PaymentOptimizedNeighbourSearch extends PaymentOptimizedStrategy {
  @override
  Either<ItemsDeliveryFailure, PaymentOptimized>? paymentFromCart(
      {required DeliveryFees deliveryFees, required String location, required List<ItemCart> inputItems, List<String>? shopsFilter}) {
    if (deliveryFees.deliveryFeeMap.isEmpty) {
      return null;
    }

    Map<String, PaymentShop> item1Shops = {};

    final List<ItemCart> items = (Utils.deepCopy(inputItems) as List<dynamic>).cast<ItemCart>();

    final emptyList = List<ItemDeliveryFailure>.empty(growable: true);
    final ItemsDeliveryFailure itemsDeliveryFailure = ItemsDeliveryFailure(items: emptyList, location: location);
// Filter unavailable shops and items whose location cannot be used

    removeNotAvailableItems(items, deliveryFees, itemsDeliveryFailure, location, shopsFilter);

    if (itemsDeliveryFailure.hasFailure()) {
      return Left(itemsDeliveryFailure);
    }

// Add items with 1 website first
    addItemsSingleLocation(items, deliveryFees, item1Shops);

// Add items with more than 1 website

    final List<ItemCart> itemsWithMoreThanOneWebsite =
        items.where((element) => element.item.websiteItems.length > 1).toList();
    if (items.isEmpty) {
      final PaymentOptimized paymentOptimized = PaymentOptimized(shopsToPay: item1Shops, location: location);
      return Right(paymentOptimized);
    }

    final shopsPayments = _initialBestPrices(itemsWithMoreThanOneWebsite, deliveryFees, item1Shops);
    PaymentOptimized bestOption = PaymentOptimized(shopsToPay: shopsPayments, location: location);

    PaymentOptimized? nextBextOption;

    while (true) {
      nextBextOption = _bestNeighbour(itemsWithMoreThanOneWebsite, deliveryFees, bestOption);
      if (nextBextOption == null) {
        break;
      } else {
        bestOption = nextBextOption;
      }
    }

    return Right(bestOption);
  }

  Map<String, PaymentShop> _initialBestPrices(
      List<ItemCart> items, DeliveryFees deliveryFees, Map<String, PaymentShop> paymentShops) {
    final Map<String, PaymentShop> paymentShopsCopy =
        Map.castFrom<dynamic, dynamic, String, PaymentShop>(Utils.deepCopy(paymentShops));

    for (int i = 0; i < items.length; i++) {
      final cartItem = items[i];
      final pagesList = cartItem.item.orderedWebsiteItemsByPrice();
      String key;
      key = pagesList[0].key;
      addItemByKey(deliveryFees, key, paymentShopsCopy, cartItem);
    }
    return paymentShopsCopy;
  }

  PaymentOptimized? _bestNeighbour(List<ItemCart> items, DeliveryFees deliveryFees, PaymentOptimized initialNeighbour) {
    final PaymentOptimized neighbourCheck = Utils.deepCopy(initialNeighbour);
    PaymentOptimized? currentBestNeighbour;

    double bestPrice = initialNeighbour.total().getRight()?.totalPrice ?? double.maxFinite;

    const epsilon = 0.000001;

    for (int i = 0; i < items.length; i++) {
      final cartItem = items[i];

      String? removedShopName;
      removedShopName = removeItem(neighbourCheck.shopsToPay, cartItem);

      final pagesList = cartItem.item.websiteItems.entries.toList();

      for (int j = 0; j < pagesList.length; j++) {
        final page = pagesList[j];
        String shopName = page.key;
        if (shopName == removedShopName) {
          continue;
        }

        addItemByKey(deliveryFees, shopName, neighbourCheck.shopsToPay, cartItem);

        final double neighbourPrice = neighbourCheck.total().getRight()?.totalPrice ?? double.maxFinite;
        if (neighbourPrice < bestPrice - epsilon) {
          bestPrice = neighbourPrice;
          currentBestNeighbour = Utils.deepCopy(neighbourCheck);
        }

        removeItemWithShopName(neighbourCheck.shopsToPay, cartItem, shopName);
      }

      addItemByKey(deliveryFees, removedShopName!, neighbourCheck.shopsToPay, cartItem);
    }

    return currentBestNeighbour;
  }
}
