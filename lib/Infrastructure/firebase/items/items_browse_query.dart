import '../../../domain/items/i_items_browse_query.dart';

class ItemsBrowseQuery extends IItemsBrowseQuery {
  ItemsBrowseQuery({required super.orderBy, super.filter, super.page});
  ItemsBrowseQuery.byName({super.filter, super.page}) : super(orderBy: "name");
  ItemsBrowseQuery.byPrice({super.filter, super.page}) : super(orderBy: "best_price");
  ItemsBrowseQuery.byUpdate({super.filter, super.page}) : super(orderBy: "last_update");

  static String get nameOrder => 'name';
  static String get priceOrder => 'best_price';
  static String get updateOrder => 'last_update';

  @override
  IItemsBrowseQuery copyWith({
    String? orderBy,
    String? filter,
    int? page,
  }) {
    return ItemsBrowseQuery(
      orderBy: orderBy ?? super.orderBy,
      filter: filter ?? super.filter,
      page: page ?? super.page,
    );
  }

}