// ignore_for_file: invalid_use_of_protected_member

import 'package:farma_compara/application/browser/browser_notifier.dart';
import 'package:farma_compara/application/browser/browser_state.dart';
import 'package:farma_compara/application/cart/cart_notifier.dart';
import 'package:farma_compara/application/cart/cart_state.dart';
import 'package:farma_compara/domain/core/sort_order.dart';
import 'package:farma_compara/domain/delivery/delivery_failure.dart';
import 'package:farma_compara/domain/delivery/i_delivery_repository.dart';
import 'package:farma_compara/domain/items/shop_list.dart';
import 'package:farma_compara/infrastructure/firebase/items/items_browse_query.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../test_fixtures.dart';

class MockDeliveryRepository extends Mock implements IDeliveryRepository {}
class MockRef extends Mock implements Ref {}

void main() {
  CartState cartState = TestFixtures.cartState;
  final mockDeliveryRepository = MockDeliveryRepository();
  final mockRef = MockRef();


  setUp(() {
    cartState = TestFixtures.cartState;

    BrowserState broswerState = BrowserState.init();



    when(() => mockRef.read(browserNotifierProvider)).thenAnswer((_) => broswerState);
  });

  test("Notifier resolves the best price from 2 items is the lowest from each item", () {
    CartNotifier cartNotifier = CartNotifier(mockDeliveryRepository, mockRef);
    cartNotifier.state = cartState.copyWith(location: "portugal");
    cartNotifier.calculateOptimizedPrices();
    final price = cartNotifier.state.paymentOptimized!.getRight()!.total().getRight()!.totalPrice;

    expect((price*100).roundToDouble() / 100,  73.91);
  });

  test("Notifier resolves the best price from 2 items is not the lowest of each item", () {
    CartNotifier cartNotifier = CartNotifier(mockDeliveryRepository, mockRef);
    cartNotifier.state = cartState.copyWith(location: "spain");
    cartNotifier.calculateOptimizedPrices();
    final price = cartNotifier.state.paymentOptimized!.getRight()!.total().getRight()!.totalPrice;

    expect((price*100).roundToDouble() / 100, 75.94);
  });

  test("Notifier resolves item3 has a location failure and a not available failure", () {
    CartNotifier cartNotifier = CartNotifier(mockDeliveryRepository, mockRef);
    cartNotifier.state = cartState.copyWith(location: "canary");
    cartNotifier.calculateOptimizedPrices();

    final failure = cartNotifier.state.paymentOptimized!.getLeft()!;

    final itemFailure = failure.items.first;

    expect(itemFailure.websites[0].failure, isA<DeliveryFailureNotFound>());
    expect(itemFailure.websites[1].failure, isA<DeliveryFailureNotAvailable>());
  });

  test("Notifier resolves it cannot obtain the best price because of disabled shops", () {

    CartNotifier cartNotifier = CartNotifier(mockDeliveryRepository, mockRef);


    BrowserState broswerState = BrowserState.init();
    final query = ItemsBrowseQuery(
        orderBy: SortOrder.name(true),
        shopList: const ShopList(shopNames: ["okfarma"])
    );
    broswerState = broswerState.copyWith(query: query);
    when(() => mockRef.read(browserNotifierProvider)).thenAnswer((_) => broswerState);


    cartNotifier.state = cartState.copyWith(location: "spain");
    cartNotifier.calculateOptimizedPrices();
    final failure = cartNotifier.state.paymentOptimized!.getLeft()!;

    final itemFailure = failure.items.first;

    expect(itemFailure.websites[0].failure, isA<DeliveryFailureDisabled>());
  });
}
