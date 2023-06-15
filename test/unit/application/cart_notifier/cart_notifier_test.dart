import 'package:farma_compara_flutter/application/cart/cart_notifier.dart';
import 'package:farma_compara_flutter/application/cart/cart_state.dart';
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
    cartNotifier.calculateOptimizedPrice();
    final price = cartNotifier.state.paymentOptimized!.total().getRight()!;

    expect(price, 73.91);
  });

  test("Notifier resolves the best price from 2 items is not the lowest of each item", () {
    CartNotifier cartNotifier = CartNotifier(mockDeliveryRepository);
    cartNotifier.state = cartState.copyWith(location: "spain");
    cartNotifier.calculateOptimizedPrice();
    final price = cartNotifier.state.paymentOptimized!.total().getRight()!;

    expect(price, 75.94);
  });
}
