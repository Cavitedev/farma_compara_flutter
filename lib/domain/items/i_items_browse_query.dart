import 'package:farma_compara_flutter/domain/core/sort_order.dart';

abstract class IItemsBrowseQuery {
  final SortOrder orderBy;
  final String? filter;
  final int page;

  const IItemsBrowseQuery({
    required this.orderBy,
    this.page = 0,
    this.filter,
  });

  IItemsBrowseQuery copyWith({
    SortOrder? orderBy,
    String? filter,
    int? page,
  });
}
