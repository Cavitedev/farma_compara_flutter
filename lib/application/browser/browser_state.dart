import 'package:farma_compara_flutter/Infrastructure/core/InternetFeedback.dart';
import 'package:farma_compara_flutter/domain/items/item.dart';

class BrowserState {
  final List<Item> items;
  final InternetFeedback? loadingFeedback;
  final int? itemsFound;

  factory BrowserState.init() {
    return const BrowserState(items: []);
  }

  BrowserState addGames(List<Item> addedItems) {
    return copyWith(items: [...items, ...addedItems], loadingFeedback: null);
  }

  bool get isLoaded => loadingFeedback == null;

  bool get allItemsFetched => itemsFound == items.length;

  //<editor-fold desc="Data Methods">
  const BrowserState({
    required this.items,
    this.loadingFeedback,
    this.itemsFound,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is BrowserState &&
          runtimeType == other.runtimeType &&
          items == other.items &&
          loadingFeedback == other.loadingFeedback &&
          itemsFound == other.itemsFound);

  @override
  int get hashCode => items.hashCode ^ loadingFeedback.hashCode ^ itemsFound.hashCode;

  @override
  String toString() {
    return 'BrowserState{' +
        ' items: $items,' +
        ' loadingFeedback: $loadingFeedback,' +
        ' productsFound: $itemsFound,' +
        '}';
  }

  BrowserState copyWith({
    List<Item>? items,
    InternetFeedback? loadingFeedback,
    int? productsFound,
  }) {
    return BrowserState(
      items: items ?? this.items,
      loadingFeedback: loadingFeedback ?? this.loadingFeedback,
      itemsFound: productsFound ?? this.itemsFound,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'items': this.items,
      'loadingFeedback': this.loadingFeedback,
      'productsFound': this.itemsFound,
    };
  }

  factory BrowserState.fromMap(Map<String, dynamic> map) {
    return BrowserState(
      items: map['items'] as List<Item>,
      loadingFeedback: map['loadingFeedback'] as InternetFeedback,
      itemsFound: map['productsFound'] as int,
    );
  }

//</editor-fold>
}
