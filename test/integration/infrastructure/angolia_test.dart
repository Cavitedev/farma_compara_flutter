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

  test("Angolia can search filtering shops", () async {
    Algolia algolia = AlgoliaApplication.algolia;
    const websites = ["okfarma","dosfarma"];

    AlgoliaQuery query = algolia.instance.index('name_algolia').query('Nuxe').facetFilter(
      websites.map((w) => "website_names:$w").toList()
    ).setPage(0).setHitsPerPage(20);
    AlgoliaQuerySnapshot snap = await query.getObjects();


    expect(snap.nbHits, greaterThan(20));

    for(final snap in snap.hits){
      final List<String> websitesSnap = List<String>.from(snap.data['website_names']);
      expect(websites.any((website) => websitesSnap.contains(website)), true);
    }

  });
}
