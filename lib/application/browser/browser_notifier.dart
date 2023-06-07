import 'package:farma_compara_flutter/core/either.dart';
import 'package:farma_compara_flutter/domain/items/i_item_repository.dart';
import 'package:farma_compara_flutter/domain/items/item.dart';
import 'package:farma_compara_flutter/domain/items/items_failure.dart';
import 'package:farma_compara_flutter/infrastructure/core/InternetFeedback.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../domain/items/i_items_browse_query.dart';
import '../../infrastructure/firebase/items/items_repository.dart';
import 'browser_state.dart';

final browserNotifierProvider = StateNotifierProvider<BrowserNotifier, BrowserState>(
    (ref) => BrowserNotifier(repository: ref.read(itemsRepositoryProvider)));

class BrowserNotifier extends StateNotifier<BrowserState> {
  BrowserNotifier({
    required this.repository,
  }) : super(BrowserState.init());

  final IItemRepository repository;
  bool isLoading = false;

  Future<void> loadItems() async {
    isLoading = true;
    state = state.copyWith(loadingFeedback: InternetLoading(url: "firebase"));
    final Either<ItemsFailure, List<Item>> itemsEither = await repository.readItemsPage(state.query);

    itemsEither.when((left) => null, (right) {
      List<Item> items = right;
      state =
          state.copyWith(items: [...state.items, ...items], query: state.query.copyWith(page: state.query.page + 1), loadingFeedback: NoFeedback());
      isLoading = false;
    });
  }

  void nextPageIfNotLoading() {
    if (!isLoading) {
      loadItems();
    }
  }

  void clear() {
    state = state.copyWith(items: [], itemsFound: null, query: state.query.copyWith(page: 0));

    loadItems();
  }

  void changeFilters(IItemsBrowseQuery query) {
    if (state.query != query) {
      state = state.copyWith(
        query: query.copyWith(page: 0),
        items: [],
        itemsFound: null,
        loadingFeedback: null,
      );
      loadItems();
    }
  }
}
