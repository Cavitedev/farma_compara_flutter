import 'package:farma_compara_flutter/core/optional.dart';
import 'package:farma_compara_flutter/domain/items/item.dart';
import 'package:farma_compara_flutter/infrastructure/firebase/items/items_browse_query.dart';

import '../../domain/items/i_items_browse_query.dart';
import '../../domain/items/firestore_failure.dart';

class BrowserState {
  final IItemsBrowseQuery query;
  final List<Item> items;
  final bool isLoading;
  final Optional<FirestoreFailure?> failure;
  final int? itemsFound;

  factory BrowserState.init() {
    return BrowserState(
      items: [],
      query: ItemsBrowseQuery.byName(page: 0),
      failure:  const Optional.value(null)
    );
  }

  BrowserState addGames(List<Item> addedItems, int itemsFound) {
    return copyWith(items: [...items, ...addedItems], isLoading: false, failure: const Optional.value(null), itemsFound: itemsFound);
  }

  bool get isLoaded => !isLoading && failure.value == null;

  bool get allItemsFetched => itemsFound == items.length;

//<editor-fold desc="Data Methods">
  const BrowserState({
    required this.query,
    required this.items,
    this.isLoading = false,
    required this.failure,
    this.itemsFound,
  });

  BrowserState copyWith({
    IItemsBrowseQuery? query,
    List<Item>? items,
    bool? isLoading,
    Optional<FirestoreFailure?>? failure,
    int? itemsFound,
  }) {
    return BrowserState(
      query: query ?? this.query,
      items: items ?? this.items,
      isLoading: isLoading ?? this.isLoading,
      failure: failure ?? this.failure,
      itemsFound: itemsFound ?? this.itemsFound,
    );
  }
}
