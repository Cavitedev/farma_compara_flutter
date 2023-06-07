import 'package:farma_compara_flutter/core/either.dart';
import 'package:farma_compara_flutter/domain/items/i_item_repository.dart';
import 'package:farma_compara_flutter/domain/items/item.dart';
import 'package:farma_compara_flutter/domain/items/items_failure.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

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
    final Either<ItemsFailure, List<Item>> itemsEither = await repository.readItemsPage(state.query);

    itemsEither.when((left) => null, (right) {
      List<Item> items = right;
      state =
          state.copyWith(items: [...state.items, ...items], query: state.query.copyWith(page: state.query.page + 1));
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
}
