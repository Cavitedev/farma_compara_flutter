import '../../../domain/items/i_items_browse_composer.dart';

class ItemsBrowseComposer extends IItemsBrowseComposer {
  ItemsBrowseComposer({required super.orderBy});
  ItemsBrowseComposer.byName({super.filter}) : super(orderBy: "name");
  ItemsBrowseComposer.byPrice({super.filter}) : super(orderBy: "best_price");
  ItemsBrowseComposer.byUpdate({super.filter}) : super(orderBy: "last_update");


  static String get nameOrder => 'name';
  static String get priceOrder => 'best_price';


}