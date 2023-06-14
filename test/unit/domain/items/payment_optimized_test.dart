import 'package:farma_compara_flutter/domain/delivery/delivery_failure.dart';
import 'package:farma_compara_flutter/domain/items/payment_optimized/payment_optimized.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../test_fixtures.dart';

void main() {
  PaymentShop paymentShop = TestFixtures.dosFarmaShop;

  setUp(() {
    paymentShop = TestFixtures.dosFarmaShop;
  });

  group("Payment shop methods", () {
    test("Items price takes the shop price", () {
      final double price = paymentShop.itemsPrice();
      expect(price, 90.33);
    });

    test("Total cost takes the lowest cost as it spends a lot of money", () {
      final double cost = paymentShop.total("spain").getRight()!;
      expect(cost, 90.33);
    });

    test("Total cost takes second lowest cost as it's payed more on other location", () {
      final double cost = paymentShop.total("formentera").getRight()!;
      expect(cost, 98.33);
    });

    test("Total cost takes second lowest cost as it's payed more on other location", () {
      const String fakeLoc = "fake spain";
      final DeliveryFailure failure = paymentShop.total(fakeLoc).getLeft()!;
      expect(failure, const DeliveryFailureNotFound(location: fakeLoc));
    });
  });
}
