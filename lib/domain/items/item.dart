import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:farma_compara_flutter/domain/core/sort_order.dart';
import 'package:flutter/material.dart';

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

  String get image {
    return websiteItems.values.firstWhere((element) => element.image != null).image!;
  }

  ShopItem firstShopItem() {
    return websiteItems.values.first;
  }

  static String websiteKeyToName(String key){
    switch(key){
      case "dosfarma":
        return "DosFarma";
      case "okfarma":
        return "OkFarma";
      case "farmaciaencasa":
        return "Farmacia en Casa";
    }
    return "Falta soporte para $key";
  }

  static Color websiteKeyToColor(String key){
    switch(key){
      case "dosfarma":
        return Colors.green.shade100;
      case "okfarma":
        return Colors.pink.shade100;
      case "farmaciaencasa":
        return Colors.yellow.shade100;
    }
    return Colors.blue.shade100;
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

    return Item(
      ref: map['ref'] as String,
      name: map['name'] as String,
      bestPrice: (map['best_price'] as num).toDouble(),
      lastUpdate: (map['last_update'] as Timestamp).toDate(),
      websiteItems: (map['website_items'] as Map).map((key, value) => MapEntry(key, ShopItem.fromFirebase(value))),
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