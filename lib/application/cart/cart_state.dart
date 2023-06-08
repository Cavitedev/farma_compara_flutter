import '../../domain/items/item.dart';

class CartState {

  final List<Item> items;

  const CartState({
    required this.items,
  });

  CartState.init(): items = [];

  CartState addItem(Item item) {
    return copyWith(items: [...items, item]);
  }

  CartState removeItem(Item item) {
    return copyWith(items: items.where((element) => element.ref != item.ref).toList());
  }


  CartState copyWith({
    List<Item>? items,
  }) {
    return CartState(
      items: items ?? this.items,
    );
  }

}