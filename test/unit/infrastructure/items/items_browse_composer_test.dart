
import 'package:farma_compara_flutter/infrastructure/firebase/items/items_browse_composer.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test("Items Browse Composer ordered by price has correct values", () {
    const String filter = "crema";
    final ItemsBrowseComposer composer = ItemsBrowseComposer.byPrice(filter:filter);
    expect(composer.orderBy, "best_price");
    expect(composer.filter, filter);

  });
}
