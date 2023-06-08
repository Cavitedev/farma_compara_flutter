import 'package:farma_compara_flutter/domain/core/sort_order.dart';

import '../../../domain/items/i_items_browse_query.dart';

class ItemsBrowseQuery extends IItemsBrowseQuery {
  ItemsBrowseQuery({required super.orderBy, super.filter, super.page});
  ItemsBrowseQuery.byName({super.filter, super.page}) : super(orderBy: SortOrder.byName());
  ItemsBrowseQuery.byPrice({super.filter, super.page}) : super(orderBy: SortOrder.byPrice());
  ItemsBrowseQuery.byUpdate({super.filter, super.page}) : super(orderBy: SortOrder.byUpdate());



  @override
  IItemsBrowseQuery copyWith({
    SortOrder? orderBy,
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