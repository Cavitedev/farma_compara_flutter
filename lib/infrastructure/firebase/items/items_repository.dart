import 'package:algolia/algolia.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:farma_compara/core/either.dart';
import 'package:farma_compara/domain/items/i_item_repository.dart';
import 'package:farma_compara/domain/items/item.dart';
import 'package:farma_compara/domain/items/items_fetch.dart';
import 'package:farma_compara/infrastructure/firebase/core/firebase_user_helper.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../domain/items/i_items_browse_query.dart';
import '../../../domain/core/firestore_failure.dart';
import '../../../algolia_application.dart';
import '../core/firebase_errors.dart';

final itemsRepositoryProvider = Provider((ref) => ItemsRepository(FirebaseFirestore.instance));

class ItemsRepository implements IItemRepository {
  final FirebaseFirestore firestore;

  ItemsRepository(this.firestore);

  @override
  Future<Either<FirestoreFailure, ItemsFetch>> readItemsPage(IItemsBrowseQuery inputQuery) async {
    try {
      final CollectionReference<Map<String, dynamic>> collection = firestore.itemsCollection();

      final Query<Map<String, dynamic>> orderedQuery =
          collection.orderBy(inputQuery.orderBy.value, descending: inputQuery.orderBy.descending);

      if (!inputQuery.isFiltering()) {
        ItemsFetch itemsFetch = await _fetchWithoutFilter(inputQuery, orderedQuery, collection);

        return Right(itemsFetch);
      }

      AlgoliaQuerySnapshot snap = await _algoliaBrowseQuery(inputQuery);

      final ids = snap.hits.map((e) => (e.data['path'] as String).split('/').last);

      ItemsFetch itemsFetch = ItemsFetch(count: snap.nbHits, items: []);
      if (ids.isEmpty) {
        return Right(itemsFetch);
      }

      List<Item> items = await _fetchItemsBrowseWithAlgolia(collection, ids, inputQuery);

      itemsFetch = itemsFetch.copyWith(items: items);

      return Right(itemsFetch);
    } catch (e) {
      return Left(FirebaseErrors.handleException(e));
    }
  }

  Future<ItemsFetch> _fetchWithoutFilter(IItemsBrowseQuery inputQuery, Query<Map<String, dynamic>> orderedQuery,
      CollectionReference<Map<String, dynamic>> collection) async {
    final queryPaginated = inputQuery.last != null && inputQuery.last!.isValid
        ? orderedQuery.startAfterDocument(inputQuery.last!.value!)
        : orderedQuery;
    final QuerySnapshot<Map<String, dynamic>> firebaseQuery = await queryPaginated.limit(40).get();

    final items = firebaseQuery.docs.map((doc) => Item.fromFirebase(doc.data())).toList();
    final lastDoc = firebaseQuery.docs.last;

    final countQuery = await collection.count().get();
    final count = countQuery.count;

    final ItemsFetch itemsFetch = ItemsFetch(items: items, count: count, documentSnapshot: lastDoc);
    return itemsFetch;
  }

  Future<AlgoliaQuerySnapshot> _algoliaBrowseQuery(IItemsBrowseQuery inputQuery) async {
    Algolia algolia = AlgoliaApplication.algolia;

    AlgoliaQuery algoliaQuery = algolia.instance
        .index('name_algolia_${inputQuery.orderBy}');

    if (inputQuery.filter != null && inputQuery.filter!.isNotEmpty) {
      algoliaQuery = algoliaQuery.query(inputQuery.filter!);
    }

    if (inputQuery.filteringPages()) {
      algoliaQuery = algoliaQuery.facetFilter(
          inputQuery.shopList.shopNames.map((page) => "website_names:$page").toList());
    }
    algoliaQuery = algoliaQuery.setPage(inputQuery.page)
        .setHitsPerPage(10);
    AlgoliaQuerySnapshot snap = await algoliaQuery.getObjects();
    return snap;
  }

  Future<List<Item>> _fetchItemsBrowseWithAlgolia(
      CollectionReference<Map<String, dynamic>> collection, Iterable<String> ids, IItemsBrowseQuery inputQuery) async {
    final QuerySnapshot<Map<String, dynamic>> firebaseQuery =
        await collection.where(FieldPath.documentId, whereIn: ids).get();
    final items = firebaseQuery.docs.map((doc) => Item.fromFirebase(doc.data())).toList();
    items.sortedBy(inputQuery.orderBy);
    return items;
  }


}
