

import 'shop_item.dart';

class Item{

  final String ref;
  List<ShopItem> shopItems;

  Item({required this.ref, required this.shopItems});

  Map<String, dynamic> toMap() {
    return {
      'ref': this.ref,
      'shopItems': this.shopItems,
    };
  }

  factory Item.fromMap(Map<String, dynamic> map) {
    return Item(
      ref: map['ref'] as String,
      shopItems: map['shopItems'] as List<ShopItem>,
    );
  }
}