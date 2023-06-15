// ignore_for_file: invalid_use_of_protected_member

import 'package:farma_compara_flutter/application/cart/cart_notifier.dart';
import 'package:farma_compara_flutter/application/cart/cart_state.dart';
import 'package:farma_compara_flutter/domain/delivery/delivery_failure.dart';
import 'package:farma_compara_flutter/domain/delivery/i_delivery_repository.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../test_fixtures.dart';

class MockDeliveryRepository extends Mock implements IDeliveryRepository {}

void main() {
  CartState cartState = TestFixtures.cartState;
  final mockDeliveryRepository = MockDeliveryRepository();

  setUp(() {
    cartState = TestFixtures.cartState;
  });

  test("Notifier resolves the best price from 2 items is the lowest from each item", () {
    CartNotifier cartNotifier = CartNotifier(mockDeliveryRepository);
    cartNotifier.state = cartState.copyWith(location: "portugal");
    cartNotifier.calculateOptimizedPrices();
    final price = cartNotifier.state.paymentOptimized!.getRight()!.total().getRight()!.totalPrice;

    expect(price, 73.91);
  });

  test("Notifier resolves the best price from 2 items is not the lowest of each item", () {
    CartNotifier cartNotifier = CartNotifier(mockDeliveryRepository);
    cartNotifier.state = cartState.copyWith(location: "spain");
    cartNotifier.calculateOptimizedPrices();
    final price = cartNotifier.state.paymentOptimized!.getRight()!.total().getRight()!.totalPrice;

    expect(price, 75.94);
  });

  test("Notifier resolves item3 has a location failure and a not available failure", () {
    CartNotifier cartNotifier = CartNotifier(mockDeliveryRepository);
    cartNotifier.state = cartState.copyWith(location: "canary");
    cartNotifier.calculateOptimizedPrices();

    final failure = cartNotifier.state.paymentOptimized!.getLeft()!;

    final itemFailure = failure.items.first;

    expect(itemFailure.websites[0].failure, isA<DeliveryFailureNotFound>());
    expect(itemFailure.websites[1].failure, isA<DeliveryFailureNotAvailable>());
  });
}
