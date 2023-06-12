import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:farma_compara_flutter/domain/core/sort_order.dart';

import '../../../core/optional.dart';
import '../../../domain/items/i_items_browse_query.dart';

class ItemsBrowseQuery extends IItemsBrowseQuery {
  ItemsBrowseQuery({required super.orderBy, super.filter, super.page, super.last});
  ItemsBrowseQuery.byName({super.filter, super.page}) : super(orderBy: SortOrder.byName());
  ItemsBrowseQuery.byPrice({super.filter, super.page}) : super(orderBy: SortOrder.byPrice());
  ItemsBrowseQuery.byUpdate({super.filter, super.page}) : super(orderBy: SortOrder.byUpdate());



  @override
  IItemsBrowseQuery copyWith({
    SortOrder? orderBy,
    String? filter,
    int? page,
    Optional<DocumentSnapshot?>? last,
  }) {
    return ItemsBrowseQuery(
      orderBy: orderBy ?? super.orderBy,
      filter: filter ?? super.filter,
      page: page ?? super.page,
      last: last ?? super.last,
    );
  }

}