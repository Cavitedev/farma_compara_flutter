import 'package:farma_compara_flutter/domain/delivery/price_range.dart';

class DeliveryFee{

  final String url;
  final Map<String, List<PriceRange>> locations;

  const DeliveryFee({
    required this.url,
    required this.locations,
  });

  Map<String, dynamic> toMap() {
    return {
      'url': this.url,
      'locations': this.locations,
    };
  }

  factory DeliveryFee.fromMap(Map<String, dynamic> map) {

    final Map<String, List<PriceRange>> locations = (map['locations'] as Map).map((key, value) {

      List<PriceRange> listRanges = [];
      if(value is List){
        listRanges = value.map((e) => PriceRange.fromMap(e)).toList();
      }else if (value is Map<String, dynamic>){
         listRanges = [PriceRange.fromMap(value)];
        return MapEntry(key, listRanges);
      }

      return MapEntry(key, listRanges);

    });


    return DeliveryFee(
      url: map['url'] as String,
      locations: locations,
    );
  }
}

