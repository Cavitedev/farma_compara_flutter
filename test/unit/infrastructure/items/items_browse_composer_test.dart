
import 'package:farma_compara/infrastructure/firebase/items/items_browse_query.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test("Items Browse Composer ordered by price has correct values", () {
    const String filter = "crema";
    final ItemsBrowseQuery composer = ItemsBrowseQuery.byPrice(filter:filter);
    expect(composer.orderBy.value, "best_price");
    expect(composer.filter, filter);

  });
}
