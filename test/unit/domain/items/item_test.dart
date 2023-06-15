import 'package:farma_compara/domain/core/sort_order.dart';
import 'package:farma_compara/domain/items/item.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  List<Item> items = [
    Item(
      ref: 'ref1',
      name: 'name1',
      bestPrice: 1.0,
      lastUpdate: DateTime(2021),
      websiteItems: {},
    ),
    Item(
      ref: 'ref2',
      name: 'name2',
      bestPrice: 2.0,
      lastUpdate: DateTime(2022),
      websiteItems: {},
    ),
    Item(
      ref: 'ref3',
      name: 'name3',
      bestPrice: 3.0,
      lastUpdate: DateTime(2023),
      websiteItems: {},
    ),
  ];

  test("Sort by name", () {
    items.sortedBy(SortOrder.byName());
    expect(items[0].name, "name1");
    expect(items[1].name, "name2");
    expect(items[2].name, "name3");
  });

  test("Sort by name desc", () {
    items.sortedBy(SortOrder.byName(descending: true));
    expect(items[0].name, "name3");
    expect(items[1].name, "name2");
    expect(items[2].name, "name1");
  });

  test("Sort by best price", () {
    items.sortedBy(SortOrder.byPrice());
    expect(items[0].bestPrice, 1.0);
    expect(items[1].bestPrice, 2.0);
    expect(items[2].bestPrice, 3.0);
  });

  test("Sort by best price desc", () {
    items.sortedBy(SortOrder.byPrice(descending: true));
    expect(items[0].bestPrice, 3.0);
    expect(items[1].bestPrice, 2.0);
    expect(items[2].bestPrice, 1.0);
  });

  test("Sort by last update", () {
    items.sortedBy(SortOrder.byUpdate());
    expect(items[0].lastUpdate.isBefore(items[1].lastUpdate), true);
    expect(items[1].lastUpdate.isBefore(items[2].lastUpdate), true);
  });

  test("Sort by last update desc", () {
    items.sortedBy(SortOrder.byUpdate(descending: true));
    expect(items[0].lastUpdate.isAfter(items[1].lastUpdate), true);
    expect(items[1].lastUpdate.isAfter(items[2].lastUpdate), true);
  });
}
