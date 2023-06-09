import 'package:farma_compara/core/either.dart';
import 'package:farma_compara/domain/items/i_item_repository.dart';
import 'package:farma_compara/domain/items/item.dart';
import 'package:farma_compara/domain/core/firestore_failure.dart';
import 'package:farma_compara/domain/items/items_fetch.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/optional.dart';
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
    if (state.allItemsFetched) return;

    isLoading = true;
    state = state.copyWith(isLoading: true);
    final Either<FirestoreFailure, ItemsFetch> itemsEither = await repository.readItemsPage(state.query);

    itemsEither.when(
      (left) => state = state.copyWith(failure: Optional.value(left), isLoading: false),
      (right) {
        List<Item> items = right.items;
        state = state.copyWith(
            items: [...state.items, ...items],
            itemsFound: right.count,
            query: state.query.copyWith(page: state.query.page + 1, last: Optional.value(right.documentSnapshot)),
            failure: const Optional(),
            isLoading: false);
        isLoading = false;
      },
    );
  }

  void nextPageIfNotLoading() {
    if (!isLoading) {
      loadItems();
    }
  }

  void clear() {
    state = state.copyWith(items: [], itemsFound: null, query: state.query.copyWith(page: 0, last: const Optional()));

    loadItems();
  }

  void loadIfEmpty(){
    if(state.items.isEmpty && !state.isLoading){
      loadItems();
    }
  }

  void changeFilters(IItemsBrowseQuery query) {
    if (state.query != query) {
      state = state.copyWith(
        query: query.copyWith(page: 0, last: const Optional()),
        items: [],
        itemsFound: null,
        isLoading: false,
        failure: const Optional(),
      );
      loadItems();
    }
  }

  void reenableWebsite(String website) {
    state = state.copyWith(
      query: state.query.copyWith(
        shopList: state.query.shopList.addShop(website),
        page: 0,
        last: const Optional(),
      ),
      items: [],
      itemsFound: null,
      isLoading: false,
      failure: const Optional(),
    );
  }
}
