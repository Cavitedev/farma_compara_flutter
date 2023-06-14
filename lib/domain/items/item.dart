import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:farma_compara_flutter/domain/core/sort_order.dart';

import 'shop_item.dart';

class Item {
  final String ref;
  final String name;
  final double bestPrice;
  final DateTime lastUpdate;
  Map<String, ShopItem> websiteItems;

  Item({
    required this.ref,
    required this.websiteItems,
    required this.name,
    required this.bestPrice,
    required this.lastUpdate,
  });

  bool get available => websiteItems.values.any((element) => element.available);
  String get availableString  {
    if (available) {
      return "Disponible";
    } else {
      return "No Disponible";
    }
  }

  String? get image {
    try{
    return websiteItems.values.firstWhere((element) => element.image != null).image!;
    }on StateError{
      return null;
    }
  }

  ShopItem firstShopItem() {
    return websiteItems.values.first;
  }

  List<MapEntry<String, ShopItem>> orderedWebsiteItemsByPrice(){
    final listWebsites = websiteItems.entries.toList();
    listWebsites.sort((a, b) => a.value.priceAvailable.compareTo(b.value.priceAvailable));
    return listWebsites;
  }


  Map<String, dynamic> toMap() {
    return {
      'ref': ref,
      'name': name,
      'bestPrice': bestPrice,
      'lastUpdate': lastUpdate,
      'websiteItems': websiteItems,
    };
  }

  factory Item.fromMap(Map<String, dynamic> map) {
    return Item(
      ref: map['ref'] as String,
      name: map['name'] as String,
      bestPrice: map['bestPrice'] as double,
      lastUpdate: map['lastUpdate'] as DateTime,
      websiteItems: map['websiteItems'] as Map<String, ShopItem>,
    );
  }

  factory Item.fromFirebase(Map<String, dynamic> map) {
    final Map<String, ShopItem> websiteItems = (map['website_items'] as Map).map((key, value) => MapEntry(key, ShopItem.fromFirebase(value)));

    return Item(
      ref: map['ref'] as String,
      name: map['name'] as String,
      bestPrice: (map['best_price'] as num?)?.toDouble() ?? websiteItems.values.reduce((a, b) => (a.price ?? double.infinity) < (b.price ?? double.infinity) ? a : b).price!,
      lastUpdate: (map['last_update'] as Timestamp).toDate(),
      websiteItems: websiteItems,
    );

  }

  Item copyWith({
    String? ref,
    String? name,
    double? bestPrice,
    DateTime? lastUpdate,
    Map<String, ShopItem>? websiteItems,
  }) {
    return Item(
      ref: ref ?? this.ref,
      name: name ?? this.name,
      bestPrice: bestPrice ?? this.bestPrice,
      lastUpdate: lastUpdate ?? this.lastUpdate,
      websiteItems: websiteItems ?? this.websiteItems,
    );
  }



}

extension ListItems on List<Item>{
  void sortedBy(SortOrder order){
    switch(order.value){
      case SortOrder.nameOrder:
        sort((pre, cur) => order.descending ? cur.name.compareTo(pre.name)  : pre.name.compareTo(cur.name));
      case SortOrder.priceOrder:
        sort((pre, cur) => order.descending ? cur.bestPrice.compareTo(pre.bestPrice)  : pre.bestPrice.compareTo(cur.bestPrice));
      case SortOrder.updateOrder:
        sort((pre, cur) => order.descending ? cur.lastUpdate.compareTo(pre.lastUpdate)  : pre.lastUpdate.compareTo(cur.lastUpdate));

    }
  }
}