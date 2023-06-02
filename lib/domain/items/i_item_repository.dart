import '../../core/either.dart';
import 'item.dart';
import 'items_failure.dart';

abstract class IItemRepository{

  Future<Either<ItemsFailure, List<Item>>> readItemsPage(int page);

}