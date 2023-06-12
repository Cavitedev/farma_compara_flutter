import 'package:cloud_firestore/cloud_firestore.dart';

import 'item.dart';

class ItemsFetch {
  final int? count;
  final List<Item> items;
  final DocumentSnapshot? documentSnapshot;

  const ItemsFetch({
    this.count,
    required this.items,
    this.documentSnapshot,
  });

  ItemsFetch copyWith({
    int? count,
    List<Item>? items,
  }) {
    return ItemsFetch(
      count: count ?? this.count,
      items: items ?? this.items,
    );
  }
}
