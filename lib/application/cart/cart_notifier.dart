import 'package:farma_compara_flutter/application/cart/cart_state.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../domain/items/item.dart';

final cartNotifierProvider = StateNotifierProvider<CartNotifier, CartState>((ref) => CartNotifier());

class CartNotifier extends StateNotifier<CartState> {
  CartNotifier() : super(CartState.init());

  void addItem(Item item) {
    state = state.addItem(item);
  }

  void removeItem(Item item) {
    state = state.removeItem(item);
  }
}
