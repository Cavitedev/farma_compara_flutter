import 'package:farma_compara_flutter/application/cart/cart_state.dart';
import 'package:farma_compara_flutter/core/either.dart';
import 'package:farma_compara_flutter/domain/delivery/delivery_fee.dart';
import 'package:farma_compara_flutter/domain/delivery/i_delivery_repository.dart';
import 'package:farma_compara_flutter/domain/items/firestore_failure.dart';
import 'package:farma_compara_flutter/infrastructure/firebase/delivery/delivery_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/optional.dart';
import '../../domain/items/item.dart';

final cartNotifierProvider =
    StateNotifierProvider<CartNotifier, CartState>((ref) => CartNotifier(ref.read(deliveryRepositoryProvider)));

class CartNotifier extends StateNotifier<CartState> {
  CartNotifier(this.repository) : super(CartState.init());

  IDeliveryRepository repository;

  Future<void> loadDeliveryFees() async {
    state = state.copyWith(isLoading: true);
    final Either<FirestoreFailure, List<DeliveryFee>> deliveryEither = await repository.updateDelivery();

    deliveryEither.when(
      (left) => state = state.copyWith(failure: Optional.value(left), isLoading: false),
      (right) {
        List<DeliveryFee> deliveryFees = right;
        state = state.copyWith(deliveryFee: deliveryFees, failure: const Optional.value(null), isLoading: false);
      },
    );
  }

  void addItem(Item item) {
    state = state.addItem(item);
  }

  void removeItem(Item item) {
    state = state.removeItem(item);
  }
}
