import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:farma_compara_flutter/core/optional.dart';
import 'package:farma_compara_flutter/domain/core/sort_order.dart';

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
}
