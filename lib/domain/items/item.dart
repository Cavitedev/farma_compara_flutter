import 'website_item.dart';

class Item {
  final String ref;
  Map<String, WebsiteItem> websiteItems;

  Item({required this.ref, required this.websiteItems});

  Map<String, dynamic> toMap() {
    return {
      'ref': this.ref,
      'website_items': this.websiteItems,
    };
  }

  factory Item.fromMap(Map<String, dynamic> map) {
    return Item(
      ref: map['ref'] as String,
      websiteItems: map['website_items'] as Map<String, WebsiteItem>,

    );
  }

  factory Item.fromFirebase(Map<String, dynamic> map) {

    return Item(
      ref: map['ref'] as String,
      websiteItems: (map['website_items'] as Map).map((key, value) => MapEntry(key, WebsiteItem.fromFirebase(value))),

    );
  }
}
