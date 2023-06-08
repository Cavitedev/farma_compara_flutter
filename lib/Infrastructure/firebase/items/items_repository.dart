import 'package:algolia/algolia.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:farma_compara_flutter/core/either.dart';
import 'package:farma_compara_flutter/domain/items/i_item_repository.dart';
import 'package:farma_compara_flutter/domain/items/item.dart';
import 'package:farma_compara_flutter/infrastructure/firebase/core/firebase_user_helper.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../domain/items/i_items_browse_query.dart';
import '../../../domain/items/firestore_failure.dart';
import '../../algolia_application.dart';
import '../core/codes.dart';

final itemsRepositoryProvider = Provider((ref) => ItemsRepository(FirebaseFirestore.instance));

class ItemsRepository implements IItemRepository {
  final FirebaseFirestore firestore;

  ItemsRepository(this.firestore);

  @override
  Future<Either<FirestoreFailure, List<Item>>> readItemsPage(IItemsBrowseQuery inputQuery) async {
    try {
      final CollectionReference<Map<String, dynamic>> collection = firestore.itemsCollection();

      final Query<Map<String, dynamic>> orderedQuery =
          collection.orderBy(inputQuery.orderBy.value, descending: inputQuery.orderBy.descending);

      if (inputQuery.filter == null) {
        final QuerySnapshot<Map<String, dynamic>> firebaseQuery = await orderedQuery.limit(20).get();
        return Right(firebaseQuery.docs.map((doc) => Item.fromFirebase(doc.data())).toList());
      }

      Algolia algolia = AlgoliaApplication.algolia;

      AlgoliaQuery algoliaQuery = algolia.instance
          .index('name_algolia_${inputQuery.orderBy}')
          .query(inputQuery.filter!)
          .setPage(inputQuery.page)
          .setHitsPerPage(10);
      AlgoliaQuerySnapshot snap = await algoliaQuery.getObjects();

      final ids = snap.hits.map((e) => (e.data['path'] as String).split('/').last);
      if(ids.isEmpty){
        return const Right([]);
      }

      final QuerySnapshot<Map<String, dynamic>> firebaseQuery =
          await collection.where(FieldPath.documentId, whereIn: ids).get();
      final items = firebaseQuery.docs.map((doc) => Item.fromFirebase(doc.data())).toList();
      items.sortedBy(inputQuery.orderBy);

      return Right(items);
    } catch (e) {
      return Left(_handleException(e));
    }
  }

  FirestoreFailure _handleException(Object e) {
    if (e is PlatformException && (e.message!.contains(PERMISSIONDENIEDCODE) || e.code == UNATHORIZED)) {
      return const FirestoreFailureInsufficientPermissions();
    } else if (e is PlatformException && e.message!.contains(NOTFOUNDCODE)) {
      return const FirestoreFailureNotFound();
    } else {
      return const FirestoreFailureUnexpected();
    }
  }
}
