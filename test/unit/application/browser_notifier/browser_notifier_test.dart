// ignore_for_file: invalid_use_of_protected_member

import 'package:farma_compara_flutter/application/browser/browser_notifier.dart';
import 'package:farma_compara_flutter/core/either.dart';
import 'package:farma_compara_flutter/domain/items/i_item_repository.dart';
import 'package:farma_compara_flutter/domain/items/item.dart';
import 'package:farma_compara_flutter/domain/items/items_fetch.dart';
import 'package:farma_compara_flutter/domain/items/shop_item.dart';
import 'package:farma_compara_flutter/infrastructure/firebase/items/items_browse_query.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockItemsRepository extends Mock implements IItemRepository {}

void main() {
  late IItemRepository itemsRepository;
  late BrowserNotifier notifier;

  setUp(() {
    itemsRepository = MockItemsRepository();
  });

  group("loadItems", () {
    test("Load games returns first page", () async {
      _mock(itemsRepository);
      notifier = BrowserNotifier(repository: itemsRepository);
      notifier.loadItems();

      await Future.delayed(const Duration(milliseconds: 200));
      expect(notifier.state.items, [item1]);
    });
  });
}

final Item item1 = Item(ref: "1", name: "Name", bestPrice: 9.99, lastUpdate: DateTime(2023), websiteItems: {
  "dosfarma":
      ShopItem(name: "Name", image: "Image", url: "url", lastUpdate: DateTime(2023), available: false, price: 9.99)
});

void _mock(IItemRepository itemsRepository) {
  when(() => itemsRepository.readItemsPage(ItemsBrowseQuery.byName())).thenAnswer((invocation) => Future.delayed(
      const Duration(milliseconds: 100),
      () => Right(
            ItemsFetch(items: [item1], count: 0),
          )));
}
