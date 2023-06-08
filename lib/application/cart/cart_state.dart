import '../../domain/items/item.dart';
import '../../domain/items/item_cart.dart';

class CartState {
  final List<ItemCart> items;

  const CartState({
    required this.items,
  });

  CartState.init() : items = [];

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
  }) {
    return CartState(
      items: items ?? this.items,
    );
  }

}
