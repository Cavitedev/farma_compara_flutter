import '../../core/either.dart';
import 'i_items_browse_query.dart';
import 'item.dart';
import 'items_failure.dart';

abstract class IItemRepository{

  Future<Either<ItemsFailure, List<Item>>> readItemsPage(IItemsBrowseQuery query);

}