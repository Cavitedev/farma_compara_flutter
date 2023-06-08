import 'package:farma_compara_flutter/domain/items/items_fetch.dart';

import '../../core/either.dart';
import 'i_items_browse_query.dart';
import 'firestore_failure.dart';

abstract class IItemRepository{

  Future<Either<FirestoreFailure, ItemsFetch>> readItemsPage(IItemsBrowseQuery inputQuery);

}