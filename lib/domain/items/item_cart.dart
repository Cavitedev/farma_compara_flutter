import '../core/i_cloneable.dart';
import 'item.dart';

class ItemCart implements ICloneable<ItemCart> {
  final Item item;
  final int quantity;

  ItemCart({
    required this.item,
    required this.quantity,
  });

  String get ref => item.ref;

  @override
  ItemCart clone() {
    return ItemCart(item: item, quantity: quantity);
  }

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
