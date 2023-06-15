import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:farma_compara/core/optional.dart';
import 'package:farma_compara/domain/core/sort_order.dart';

abstract class IItemsBrowseQuery {
  final SortOrder orderBy;
  final String? filter;
  final int page;
  final Optional<DocumentSnapshot?>? last;

  const IItemsBrowseQuery({
    required this.orderBy,
    this.page = 0,
    this.filter,
    this.last,
  });

  IItemsBrowseQuery copyWith({
    SortOrder? orderBy,
    String? filter,
    int? page,
    final Optional<DocumentSnapshot?> last
  });

  bool isFiltering() => filter != null && filter!.isNotEmpty;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is IItemsBrowseQuery &&
          runtimeType == other.runtimeType &&
          orderBy == other.orderBy &&
          filter == other.filter &&
          page == other.page &&
          last == other.last;

  @override
  int get hashCode => orderBy.hashCode ^ filter.hashCode ^ page.hashCode ^ last.hashCode;
}
