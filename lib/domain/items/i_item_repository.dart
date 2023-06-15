import 'package:farma_compara/domain/items/items_fetch.dart';

import '../../core/either.dart';
import 'i_items_browse_query.dart';
import '../core/firestore_failure.dart';

abstract class IItemRepository{

  Future<Either<FirestoreFailure, ItemsFetch>> readItemsPage(IItemsBrowseQuery inputQuery);

}