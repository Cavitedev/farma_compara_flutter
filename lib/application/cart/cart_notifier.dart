import 'package:farma_compara/application/browser/browser_notifier.dart';
import 'package:farma_compara/application/cart/cart_state.dart';
import 'package:farma_compara/core/either.dart';
import 'package:farma_compara/domain/delivery/delivery_failure.dart';
import 'package:farma_compara/domain/delivery/delivery_fee.dart';
import 'package:farma_compara/domain/delivery/delivery_fees.dart';
import 'package:farma_compara/domain/delivery/i_delivery_repository.dart';
import 'package:farma_compara/domain/core/firestore_failure.dart';
import 'package:farma_compara/domain/items/payment_optimized/algorithm/payment_optimized_neighbour_search.dart';
import 'package:farma_compara/domain/items/payment_optimized/payment_optimized.dart';
import 'package:farma_compara/infrastructure/firebase/delivery/delivery_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/optional.dart';
import '../../domain/items/item.dart';

final cartNotifierProvider =
    StateNotifierProvider<CartNotifier, CartState>((ref) => CartNotifier(
        ref.read(deliveryRepositoryProvider), ref)
    );

class CartNotifier extends StateNotifier<CartState> {
  CartNotifier(this.repository, this.ref) : super(CartState.init());
  final Ref ref;

  IDeliveryRepository repository;

  Future<void> loadDeliveryFees() async {
    state = state.copyWith(isLoading: true);
    final Either<FirestoreFailure, Map<String, DeliveryFee>> deliveryEither = await repository.updateDelivery();

    deliveryEither.when(
      (left) => state = state.copyWith(failure: Optional.value(left), isLoading: false),
      (right) {
        Map<String, DeliveryFee> deliveryFees = right;
        state = state.copyWith(
            deliveryFees: DeliveryFees(deliveryFeeMap: deliveryFees), failure: const Optional(), isLoading: false);
        calculateOptimizedPrices();
      },
    );
  }

  void addItem(Item item) {
    state = state.addItem(item);
    calculateOptimizedPrices();
  }

  void removeItem(Item item) {
    state = state.removeItem(item);
    calculateOptimizedPrices();
  }

  void updateLocation(String location) {
    state = state.copyWith(location: location);
    calculateOptimizedPrices();
  }

  void calculateOptimizedPrices() {
    final Either<ItemsDeliveryFailure, PaymentOptimized>? paymentOptimized =
        PaymentOptimizedNeighbourSearch().paymentFromCart(
      deliveryFees: state.deliveryFees,
      location: state.location,
      inputItems: state.items,
      shopsFilter: ref.read(browserNotifierProvider).query.shopList.shopNames,
    );
    state = state.copyWith(paymentOptimized: paymentOptimized);
  }
}
