import 'package:farma_compara_flutter/core/either.dart';
import 'package:farma_compara_flutter/domain/delivery/delivery_failure.dart';

import '../../core/optional.dart';
import '../../domain/delivery/delivery_fees.dart';
import '../../domain/core/firestore_failure.dart';
import '../../domain/items/item.dart';
import '../../domain/items/item_cart.dart';
import '../../domain/items/payment_optimized/payment_optimized.dart';

class CartState {
  final List<ItemCart> items;
  final DeliveryFees deliveryFees;
  final bool isLoading;
  final Optional<FirestoreFailure> failure;
  final Either<ItemsDeliveryFailure, PaymentOptimized>? paymentOptimized;
  final String location;

  const CartState(
      {required this.items,
      required this.deliveryFees,
      this.isLoading = false,
      this.failure = const Optional(),
      this.paymentOptimized,
      this.location = "spain"});

  CartState.init()
      : items = [],
        failure = const Optional(),
        isLoading = false,
        deliveryFees = DeliveryFees.init(),
        paymentOptimized = null,
        location = "spain";

  int get totalItems => items.fold(0, (previousValue, element) => previousValue + element.quantity);

  CartState addItem(Item item) {
    if (items.any((element) => element.ref == item.ref)) {
      return copyWith(items: items.map((e) => e.ref == item.ref ? e.copyWith(quantity: e.quantity + 1) : e).toList());
    } else {
      return copyWith(items: [...items, ItemCart(item: item, quantity: 1)]);
    }
  }

  CartState removeItem(Item item) {
    if (items.any((element) => element.ref == item.ref)) {
      final itemCart = items.firstWhere((element) => element.ref == item.ref);
      if (itemCart.quantity == 1) {
        return copyWith(items: items.where((element) => element.ref != item.ref).toList());
      } else {
        return copyWith(items: items.map((e) => e.ref == item.ref ? e.copyWith(quantity: e.quantity - 1) : e).toList());
      }
    } else {
      return this;
    }
  }

  CartState removeItemCompletely(Item item) {
    return copyWith(items: items.where((element) => element.ref != item.ref).toList());
  }

  double totalPrice() {
    return items.fold(0, (previousValue, element) => previousValue + element.item.bestPrice * element.quantity);
  }

  CartState copyWith({
    List<ItemCart>? items,
    DeliveryFees? deliveryFees,
    bool? isLoading,
    Optional<FirestoreFailure>? failure,
    Either<ItemsDeliveryFailure, PaymentOptimized>? paymentOptimized,
    String? location,
  }) {
    return CartState(
      items: items ?? this.items,
      deliveryFees: deliveryFees ?? this.deliveryFees,
      isLoading: isLoading ?? this.isLoading,
      failure: failure ?? this.failure,
      paymentOptimized: paymentOptimized ?? this.paymentOptimized,
      location: location ?? this.location,
    );
  }
}
