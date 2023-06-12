import 'package:farma_compara_flutter/domain/delivery/delivery_fee.dart';

import '../../core/optional.dart';
import '../../domain/items/firestore_failure.dart';
import '../../domain/items/item.dart';
import '../../domain/items/item_cart.dart';

class CartState {
  final List<ItemCart> items;
  final List<DeliveryFee>? deliveryFee;
  final bool isLoading;
  final Optional<FirestoreFailure?> failure;

  const CartState({
    required this.items,
    this.deliveryFee,
    this.isLoading = false,
    this.failure = const Optional.value(null),
  });

  CartState.init() : items = [], failure = const Optional.value(null), isLoading=false, deliveryFee = null;

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
    List<DeliveryFee>? deliveryFee,
    bool? isLoading,
    Optional<FirestoreFailure?>? failure,
  }) {
    return CartState(
      items: items ?? this.items,
      deliveryFee: deliveryFee ?? this.deliveryFee,
      isLoading: isLoading ?? this.isLoading,
      failure: failure ?? this.failure,
    );
  }
}
