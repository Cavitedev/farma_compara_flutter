import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:farma_compara/core/optional.dart';
import 'package:farma_compara/domain/core/sort_order.dart';
import 'package:farma_compara/domain/items/shop_list.dart';

abstract class IItemsBrowseQuery {
  final SortOrder orderBy;
  final String? filter;
  final int page;

  final ShopList shopList;

  final Optional<DocumentSnapshot?>? last;


  const IItemsBrowseQuery({
    required this.orderBy,
    required this.shopList,
    this.page = 0,
    this.filter,
    this.last,
  });


  IItemsBrowseQuery copyWith({
    SortOrder? orderBy,
    String? filter,
    int? page,
    final Optional<DocumentSnapshot?> last,
    ShopList shopList,
  });

  bool isFiltering() => filter != null && filter!.isNotEmpty || filteringPages();
  bool filteringPages () => shopList.filteringPages();

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is IItemsBrowseQuery &&
          runtimeType == other.runtimeType &&
          orderBy == other.orderBy &&
          filter == other.filter &&
          page == other.page &&
          shopList == other.shopList &&
          last == other.last;

  @override
  int get hashCode => orderBy.hashCode ^ filter.hashCode ^ page.hashCode ^ shopList.hashCode ^ last.hashCode;
}
