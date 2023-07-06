import 'package:algolia/algolia.dart';
import 'package:farma_compara/algolia_application.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test("Angolia search by name returns some values", () async {
    Algolia algolia = AlgoliaApplication.algolia;

    AlgoliaQuery query = algolia.instance.index('name_algolia').query('Nuxe').setPage(0).setHitsPerPage(20);
    AlgoliaQuerySnapshot snap = await query.getObjects();




    expect(snap.nbHits, greaterThan(20));
    expect(snap.hits.length, 20);
  });
}
