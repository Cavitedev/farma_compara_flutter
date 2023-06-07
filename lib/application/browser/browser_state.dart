import 'package:farma_compara_flutter/domain/items/item.dart';
import 'package:farma_compara_flutter/infrastructure/firebase/items/items_browse_query.dart';

import '../../domain/items/i_items_browse_query.dart';
import '../../infrastructure/core/InternetFeedback.dart';

class BrowserState {
  final IItemsBrowseQuery query;
  final List<Item> items;
  final InternetFeedback loadingFeedback;
  final int? itemsFound;

  factory BrowserState.init() {
    return BrowserState(
      items: [],
      query: ItemsBrowseQuery.byName(page: 0),
      loadingFeedback: NoFeedback(),
    );
  }

  BrowserState addGames(List<Item> addedItems) {
    return copyWith(items: [...items, ...addedItems], loadingFeedback: null);
  }

  bool get isLoaded => loadingFeedback is NoFeedback;

  bool get allItemsFetched => itemsFound == items.length;

//<editor-fold desc="Data Methods">
  const BrowserState({
    required this.query,
    required this.items,
    required this.loadingFeedback,
    this.itemsFound,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is BrowserState &&
          runtimeType == other.runtimeType &&
          query == other.query &&
          items == other.items &&
          loadingFeedback == other.loadingFeedback &&
          itemsFound == other.itemsFound);

  @override
  int get hashCode => query.hashCode ^ items.hashCode ^ loadingFeedback.hashCode ^ itemsFound.hashCode;

  @override
  String toString() {
    return 'BrowserState{' +
        ' query: $query,' +
        ' items: $items,' +
        ' loadingFeedback: $loadingFeedback,' +
        ' itemsFound: $itemsFound,' +
        '}';
  }

  BrowserState copyWith({
    IItemsBrowseQuery? query,
    List<Item>? items,
    InternetFeedback? loadingFeedback,
    int? itemsFound,
  }) {
    return BrowserState(
      query: query ?? this.query,
      items: items ?? this.items,
      loadingFeedback: loadingFeedback ?? this.loadingFeedback,
      itemsFound: itemsFound ?? this.itemsFound,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'query': this.query,
      'items': this.items,
      'loadingFeedback': this.loadingFeedback,
      'itemsFound': this.itemsFound,
    };
  }

  factory BrowserState.fromMap(Map<String, dynamic> map) {
    return BrowserState(
      query: map['query'] as IItemsBrowseQuery,
      items: map['items'] as List<Item>,
      loadingFeedback: map['loadingFeedback'] as InternetFeedback,
      itemsFound: map['itemsFound'] as int,
    );
  }

//</editor-fold>
}
