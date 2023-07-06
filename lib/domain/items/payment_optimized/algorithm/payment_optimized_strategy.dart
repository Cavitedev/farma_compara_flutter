import 'package:farma_compara/domain/items/payment_optimized/payment_optimized.dart';
import 'package:flutter/cupertino.dart';

import '../../../../core/either.dart';
import '../../../delivery/delivery_failure.dart';
import '../../../delivery/delivery_fee.dart';
import '../../../delivery/delivery_fees.dart';
import '../../item_cart.dart';
import '../../shop_item.dart';

 abstract class PaymentOptimizedStrategy {
   Either<ItemsDeliveryFailure, PaymentOptimized>? paymentFromCart(
      {required DeliveryFees deliveryFees, required String location, required List<ItemCart> inputItems});

  @protected
  void removeNotAvailableItems(
      List<ItemCart> items, DeliveryFees deliveryFees, ItemsDeliveryFailure itemsFailure, String location) {
    for (int i = 0; i < items.length; i++) {
      final cartItem = items[i];
      Map<String, ShopItem> filteredWebsiteItems = {};

      final ItemDeliveryFailure itemfailure = ItemDeliveryFailure(item: cartItem.item, websites: []);

      for (final websiteItem in cartItem.item.websiteItems.entries) {
        final fee = deliveryFees.deliveryFeeMap[websiteItem.key]!;

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

  @protected
   PaymentOptimized? getBestPaymentOptimized(List<Map<String, PaymentShop>> paymentShopOptions, String location, double bestPrice, PaymentOptimized? bestOption) {
     for (final option in paymentShopOptions) {
       final payOption = PaymentOptimized(shopsToPay: option, location: location);
       double price = payOption.total().getRight()!.totalPrice;

       if (price < bestPrice) {
         bestOption = payOption;
         bestPrice = price;
       }
     }
     return bestOption;
   }

  @protected
  void addItemByKey(DeliveryFees deliveryFees, String key, Map<String, PaymentShop> paymentShops, ItemCart cartItem) {
    final DeliveryFee fee = deliveryFees.deliveryFeeMap[key]!;

    if (paymentShops.containsKey(key)) {
      paymentShops[key]!.items.add(cartItem);
    } else {
      final PaymentShop paymentShop = PaymentShop(shopName: key, fee: fee, items: [cartItem]);
      paymentShops[key] = paymentShop;
    }
  }

   @protected
   String? removeItem(Map<String, PaymentShop> paymentShops, ItemCart cartItem) {

    String? removedShopName;
     paymentShops.forEach((key, shop) {
       bool hasRemoved = shop.items.remove(cartItem);
       if(hasRemoved){
         removedShopName = key;
         return;
       }
     });

     return removedShopName;
   }

   @protected
   bool removeItemWithShopName(Map<String, PaymentShop> paymentShops, ItemCart cartItem, String shopName) {
     return paymentShops[shopName]!.items.remove(cartItem);
   }

  @protected
  void addItemsSingleLocation(List<ItemCart> items, DeliveryFees deliveryFees, Map<String, PaymentShop> paymentShops) {
    for (final cartItem in items) {
      if (cartItem.item.websiteItems.length == 1) {
        final String key = cartItem.item.websiteItems.keys.first;
        addItemByKey(deliveryFees, key, paymentShops, cartItem);
      }
    }
  }
}
