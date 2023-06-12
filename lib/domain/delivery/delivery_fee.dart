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
    return DeliveryFee(
      url: map['url'] as String,
      locations: map['locations'] as Map<String, List<PriceRange>>,
    );
  }
}

