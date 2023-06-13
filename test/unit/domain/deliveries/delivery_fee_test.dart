import 'package:farma_compara_flutter/domain/delivery/delivery_failure.dart';
import 'package:farma_compara_flutter/domain/delivery/delivery_fee.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../test_fixtures.dart';

void main() {
  final DeliveryFee deliveryFee = TestFixtures.farmaciaEnCasa;

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
    expect(cost, 2.99);
  });

  test("Delivery is high when cost is in the first range", () {
    final double cost = deliveryFee.priceFromCost("spain", 0).getRight()!;
    expect(cost, 3.99);
  });

  test("Delivery to inner location returns the first result of outer location", () {
    final double cost = deliveryFee.priceFromCost("ibiza", 95).getRight()!;
    expect(cost, 4.99);
  });
}
