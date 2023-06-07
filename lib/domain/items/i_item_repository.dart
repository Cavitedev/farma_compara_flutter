import '../../core/either.dart';
import 'i_items_browse_query.dart';
import 'item.dart';
import 'firestore_failure.dart';

abstract class IItemRepository{

  Future<Either<FirestoreFailure, List<Item>>> readItemsPage(IItemsBrowseQuery inputQuery);

}