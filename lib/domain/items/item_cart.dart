import 'item.dart';

class ItemCart{

  final Item item;
  final int quantity;

  ItemCart({required this.item, required this.quantity});

  String get ref => item.ref;

  ItemCart copyWith({
    Item? item,
    int? quantity,
  }) {
    return ItemCart(
      item: item ?? this.item,
      quantity: quantity ?? this.quantity,
    );
  }
}