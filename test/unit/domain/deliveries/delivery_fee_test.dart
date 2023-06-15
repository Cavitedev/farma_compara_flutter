import 'package:farma_compara_flutter/domain/delivery/delivery_failure.dart';
import 'package:farma_compara_flutter/domain/delivery/delivery_fee.dart';
import 'package:farma_compara_flutter/domain/delivery/price_range.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../test_fixtures.dart';

void main() {
  final DeliveryFee deliveryFee = TestFixtures.farmaciaEnCasaFees;

  test("Test if it can be delivered to a non existant region, returns false", () {
    final canBeDelivered = deliveryFee.canBeDeliveredIn("canary");
    expect(canBeDelivered, false);
  });

  test("Delivery is requested on a place that cannot send items", () {
    const location = "fake spain";
    final result = deliveryFee.priceFromCost(location, 29.99);
    expect(result.isLeft(), true);
    expect(result.getLeft()!, const DeliveryFailureNotFound(location: location));
  });

  test("Delivery is free is the cost is high enough", () {
    final double cost = deliveryFee.priceFromCost("spain", 60).getRight()!;
    expect(cost, 0);
  });

  test("Delivery is middle when cost is on the second range", () {
    final double cost = deliveryFee.priceFromCost("spain", 59.99).getRight()!;
    expect(cost, 1.99);
  });

  test("Delivery is high when cost is in the first range", () {
    final double cost = deliveryFee.priceFromCost("spain", 0).getRight()!;
    expect(cost, 3.99);
  });

  test("Delivery to inner location returns the first result of outer location", () {
    final double cost = deliveryFee.priceFromCost("ibiza", 95).getRight()!;
    expect(cost, 4.99);
  });

  test("Delivery fees can be grouped by min and max price", () {
    final List<Map<String, List<PriceRange>>> groupedByPrice = deliveryFee.groupedByPrice();

    final expected = [
      {
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
        ]
      },
      {
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
      }
    ];
    expect(groupedByPrice, expected);
  });


}
