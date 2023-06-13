import 'package:farma_compara_flutter/domain/delivery/delivery_fee.dart';
import 'package:farma_compara_flutter/domain/delivery/price_range.dart';
import 'package:farma_compara_flutter/domain/items/item.dart';
import 'package:farma_compara_flutter/domain/items/item_cart.dart';
import 'package:farma_compara_flutter/domain/items/payment_optimized/payment_optimized.dart';
import 'package:farma_compara_flutter/domain/items/shop_item.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  PaymentShop paymentShop = dosFarmaShop();

  setUp(() {
    paymentShop = dosFarmaShop();
  });

  group("Payment shop methods", () {
    test("Items price takes the shop price", () {
      final double price = paymentShop.itemsPrice();
      expect(price, 90.33);
    });

    // test("Total cost takes the lowest cost as it spends a lot of money", () {
    //   final double deliveryCost = paymentShop.deliveryCost();
    // });
  });

}

PaymentShop dosFarmaShop() => PaymentShop(
    shopName: "dosfarma",
    fee: DeliveryFee(
      locations: {
        "spain": [
          PriceRange(
            price: 5.0,
            max: 30.0,
          ),
          PriceRange(price: 1.0, min: 30.01, max: 50),
          PriceRange(
            price: 0.0,
            min: 50.01,
          )
        ]
      },
      url: "https://www.dosfarma.com",
    ),
    items: [
      ItemCart(
          item: Item(
            bestPrice: 10.0,
            name: "Paracetamol",
            ref: "1",
            lastUpdate: DateTime(2021),
            websiteItems: {
              "dosfarma": ShopItem(
                price: 10.11,
                available: false,
                name: "t",
                url: "https://www.dosfarma.com",
                lastUpdate: DateTime(2021),
                image: "img",
              )
            },
          ),
          quantity: 3),
      ItemCart(
          item: Item(
            bestPrice: 12,
            name: "Paracetamol",
            ref: "1",
            lastUpdate: DateTime(2021),
            websiteItems: {
              "dosfarma": ShopItem(
                price: 15,
                available: false,
                name: "t",
                url: "https://www.dosfarma.com",
                lastUpdate: DateTime(2021),
                image: "img",
              )
            },
          ),
          quantity: 4)
    ]);

