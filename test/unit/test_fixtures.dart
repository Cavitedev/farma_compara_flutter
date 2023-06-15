import 'package:farma_compara_flutter/application/cart/cart_state.dart';
import 'package:farma_compara_flutter/domain/delivery/delivery_fee.dart';
import 'package:farma_compara_flutter/domain/delivery/delivery_fees.dart';
import 'package:farma_compara_flutter/domain/delivery/price_range.dart';
import 'package:farma_compara_flutter/domain/items/item.dart';
import 'package:farma_compara_flutter/domain/items/item_cart.dart';
import 'package:farma_compara_flutter/domain/items/item_utils.dart';
import 'package:farma_compara_flutter/domain/items/payment_optimized/payment_optimized.dart';
import 'package:farma_compara_flutter/domain/items/shop_item.dart';

class TestFixtures {
  static CartState cartState = CartState(
      items: [
        ItemCart(item: item1, quantity: 4),
        ItemCart(item: item2, quantity: 1),
        ItemCart(item: item3, quantity: 2)
      ],
      deliveryFees: DeliveryFees(deliveryFeeMap: {
        "farmaciaencasa": farmaciaEnCasaFees,
        "okfarma": okFarmaFees,
      }));

  static Item item1 = Item(
      ref: "100",
      websiteItems: {
        "farmaciaencasa": ShopItem(
          name: "name 1",
          price: 15.99,
          lastUpdate: DateTime(2022),
          url: "https://www.dosfarma.com/parafarmacia/parafarmacia-online.html",
          available: true,
        ),
        "okfarma": ShopItem(
          name: "name 1",
          price: 9.99,
          lastUpdate: DateTime(2022),
          url: "https://www.okfarma.es/",
          available: true,
        ),
      },
      name: "name 1 ",
      bestPrice: 9.99,
      lastUpdate: DateTime(2022));

  static Item item2 = Item(
      ref: "102",
      websiteItems: {
        "farmaciaencasa": ShopItem(
          name: "name 2",
          price: 6,
          lastUpdate: DateTime(2022),
          url: "https://www.dosfarma.com/parafarmacia/parafarmacia-online.html",
          available: true,
        ),
        "okfarma": ShopItem(
          name: "name 2",
          price: 5,
          lastUpdate: DateTime(2022),
          url: "https://www.okfarma.es/",
          available: true,
        ),
      },
      name: "name 2",
      bestPrice: 5,
      lastUpdate: DateTime(2022));

  static Item item3 = Item(
      ref: "103",
      websiteItems: {
        "farmaciaencasa": ShopItem(
          name: "name 3",
          price: 12,
          lastUpdate: DateTime(2022),
          url: "https://www.dosfarma.com/parafarmacia/parafarmacia-online.html",
          available: true,
        ),
        "okfarma": ShopItem(
          name: "name 3",
          price: 3,
          lastUpdate: DateTime(2022),
          url: "https://www.dosfarma.com/parafarmacia/parafarmacia-online.html",
          available: false,
        ),
      },
      name: "name 3",
      bestPrice: 12,
      lastUpdate: DateTime(2022));

  static DeliveryFees deliveryFees =
      DeliveryFees(deliveryFeeMap: {ItemUtils.okFarma: okFarmaFees, ItemUtils.farmaciaEnCasa: farmaciaEnCasaFees});

  static DeliveryFee farmaciaEnCasaFees = DeliveryFee(
    locations: {
      "spain": [
        PriceRange(
          price: 3.99,
          min: 1,
          max: 29.99,
        ),
        PriceRange(price: 1.99, min: 30, max: 59.99),
        PriceRange(price: 0.0, min: 60, max: 0)
      ],
      "portugal": [
        PriceRange(
          price: 4.95,
          min: 1,
          max: 29.99,
        ),
        PriceRange(price: 3.95, min: 30, max: 59.99),
        PriceRange(price: 0.0, min: 60, max: 0)
      ],
      "balearic": [
        PriceRange(
          price: 5.99,
          min: 1,
          max: 49.99,
        ),
        PriceRange(price: 4.99, min: 50, max: 99.99),
        PriceRange(price: 0.0, min: 100, max: 0)
      ],
      "formentera": [
        PriceRange(
          price: 9.69,
          min: 1,
          max: 49.99,
        ),
        PriceRange(price: 6.69, min: 50, max: 99.99),
        PriceRange(price: 0.0, min: 100, max: 0)
      ]
    },
    url: "https://www.farmaciaencasaonline.es/farmacia-en-casa-online-tarifas-y-condiciones-de-envio",
  );

  static DeliveryFee okFarmaFees = DeliveryFee(
    locations: {
      "spain": [
        PriceRange(
          price: 3.99,
          min: 0,
          max: 48.99,
        ),
        PriceRange(price: 0, min: 49, max: 58.99),
        PriceRange(price: 0, min: 59, max: 68.99),
        PriceRange(price: 0, min: 69),
      ],
      "portugal": [
        PriceRange(
          price: 4.99,
          min: 0,
          max: 40,
        ),
        PriceRange(price: 0, min: 40.01),
      ],
      "balearic": [
        PriceRange(
          price: 8.95,
          min: 9,
          max: 118.99,
        ),
        PriceRange(price: 0, min: 119),
      ],
      "canary": [
        PriceRange(
          price: 8.95,
          min: 9,
          max: 118.99,
        ),
        PriceRange(price: 0, min: 119),
      ]
    },
    url: "https://okfarma.es/envio",
  );

  static PaymentShop dosFarmaShop = PaymentShop(
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
          ],
          "formentera": [
            PriceRange(
              price: 10,
              max: 50.0,
            ),
            PriceRange(price: 8, min: 50.01, max: 100),
            PriceRange(
              price: 0.0,
              min: 100,
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
}
