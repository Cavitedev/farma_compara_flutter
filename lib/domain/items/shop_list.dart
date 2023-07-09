import 'package:farma_compara/domain/items/item_utils.dart';
import 'package:collection/collection.dart';

class ShopList{

  final List<String> shopNames;

  const ShopList({
    required this.shopNames,
  });


  ShopList.empty(): shopNames = [];
  ShopList.full(): shopNames = List.from(ItemUtils.shopNamesList);

  bool filteringPages () => !const ListEquality().equals(shopNames, ItemUtils.shopNamesList) ;

  ShopList addShop(String shopName){
    if(!ItemUtils.shopNamesList.contains(shopName)){
      throw ArgumentError('Shop name $shopName is not valid');
    }

    return copyWith(
      shopNames: [...shopNames, shopName]
    );
  }

  ShopList removeShop(String shopName){
    if(!ItemUtils.shopNamesList.contains(shopName)){
      throw ArgumentError('Shop name $shopName is not valid');
    }

    return copyWith(
      shopNames: shopNames.where((element) => element != shopName).toList()
    );
  }

//<editor-fold desc="Data Methods">


  @override
  bool operator ==(Object other) =>
      identical(this, other) || (other is ShopList && runtimeType == other.runtimeType && shopNames == other.shopNames);

  @override
  int get hashCode => shopNames.hashCode;

  @override
  String toString() {
    return 'ShopList{' + ' shopNames: $shopNames,' + '}';
  }

  ShopList copyWith({
    List<String>? shopNames,
  }) {
    return ShopList(
      shopNames: shopNames ?? this.shopNames,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'shopNames': shopNames,
    };
  }

  factory ShopList.fromMap(Map<String, dynamic> map) {
    return ShopList(
      shopNames: map['shopNames'] as List<String>,
    );
  }

//</editor-fold>
}