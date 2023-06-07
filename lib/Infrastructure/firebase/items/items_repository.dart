import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:farma_compara_flutter/core/either.dart';
import 'package:farma_compara_flutter/domain/items/i_item_repository.dart';
import 'package:farma_compara_flutter/domain/items/item.dart';
import 'package:farma_compara_flutter/infrastructure/firebase/core/firebase_user_helper.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../domain/items/i_items_browse_query.dart';
import '../../../domain/items/items_failure.dart';
import '../core/codes.dart';

final itemsRepositoryProvider = Provider((ref) => ItemsRepository(FirebaseFirestore.instance));

class ItemsRepository implements IItemRepository {
  final FirebaseFirestore firestore;

  ItemsRepository(this.firestore);

  @override
  Future<Either<ItemsFailure, List<Item>>> readItemsPage(IItemsBrowseQuery query) async {
    try {
      final CollectionReference<Map<String, dynamic>> collection = firestore.itemsCollection();

      final QuerySnapshot<Map<String, dynamic>> query =
          await collection.where("name", arrayContains: "Nuxe").limit(20).get();
      return Right(query.docs.map((doc) => Item.fromFirebase(doc.data())).toList());
    } catch (e) {
      return Left(_handleException(e));
    }
  }

  ItemsFailure _handleException(Object e) {
    if (e is PlatformException && (e.message!.contains(PERMISSIONDENIEDCODE) || e.code == UNATHORIZED)) {
      return const ItemsFailureInsufficientPermissions();
    } else if (e is PlatformException && e.message!.contains(NOTFOUNDCODE)) {
      return const ItemsFailureNotFound();
    } else {
      return const ItemsFailureUnexpected();
    }
  }
}
