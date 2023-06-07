abstract class IItemsBrowseQuery {
  final String orderBy;
  final String? filter;
  final int page;

  const IItemsBrowseQuery({
    required this.orderBy,
    this.page = 0,
    this.filter,
  });

  IItemsBrowseQuery copyWith({
    String? orderBy,
    String? filter,
    int? page,
  });
}
