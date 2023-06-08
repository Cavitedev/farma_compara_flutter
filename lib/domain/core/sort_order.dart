class SortOrder {
  final String value;
  final bool descending;

  SortOrder({
    required this.value,
    this.descending = false,
  });

  SortOrder.byName({bool descending = false}) : this(value: nameOrder, descending: descending);
  SortOrder.byPrice({bool descending = false}) : this(value: priceOrder, descending: descending);
  SortOrder.byUpdate({bool descending = false}) : this(value: updateOrder, descending: descending);


  SortOrder.name(bool descending): this(value: nameOrder, descending: descending);

  static const String nameOrder = 'name';
  static const String priceOrder = 'best_price';
  static const String updateOrder = 'last_update';




  SortOrder inverse(){
    return SortOrder(
      value: value,
      descending: !descending,
    );
  }

  SortOrder copyWith({
    String? sortCat,
    bool? descending,
  }) {
    return SortOrder(
      value: sortCat ?? this.value,
      descending: descending ?? this.descending,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is SortOrder && runtimeType == other.runtimeType && value == other.value && descending == other.descending;

  @override
  int get hashCode => value.hashCode ^ descending.hashCode;

  @override
  String toString() {
    return '${value}_${descending ? "desc" : "asc"}';
  }
}
