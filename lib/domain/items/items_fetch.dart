import 'item.dart';

class ItemsFetch {
  final int? count;
  final List<Item> items;

  const ItemsFetch({
    this.count,
    required this.items,
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
