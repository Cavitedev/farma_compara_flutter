import 'package:farma_compara_flutter/domain/delivery/delivery_failure.dart';
import 'package:farma_compara_flutter/domain/delivery/price_range.dart';
import 'package:farma_compara_flutter/domain/locations/locations_hierarchy.dart';

import '../../core/either.dart';

class DeliveryFee {
  final String url;
  final Map<String, List<PriceRange>> locations;

  const DeliveryFee({
    required this.url,
    required this.locations,
  });

  Either<DeliveryFailure, double> priceFromCost(String location, double cost) {
    final List<PriceRange> ranges = _getLocationPrices(location);

    for (final PriceRange range in ranges) {
      if (cost >= range.min && cost <= range.max) {
        return Right(range.price);
      }
    }
    if (ranges.isNotEmpty) {
      final minPriceDelivery = ranges.reduce((value, element) => value.min < element.min ? value : element);
      final maxPriceDelivery = ranges.reduce((value, element) => value.max > element.max ? value : element);

      if (cost < minPriceDelivery.min) {
        return Right(minPriceDelivery.price);
      } else if (cost > maxPriceDelivery.max) {
        return Right(maxPriceDelivery.price);
      }
    }

    return Left(DeliveryFailureNotFound(location: location));
  }

  List<PriceRange> _getLocationPrices(String location) {
    if (locations.containsKey(location)) {
      return locations[location]!;
    }
    final upperLocations = LocationsHierarchy.upperLocationsFrom(location);

    for (final upperLocation in upperLocations) {
      if (locations.containsKey(upperLocation)) {
        return locations[upperLocation]!;
      }
    }

    return [];
  }

  Map<String, dynamic> toMap() {
    return {
      'url': this.url,
      'locations': this.locations,
    };
  }

  factory DeliveryFee.fromMap(Map<String, dynamic> map) {
    final Map<String, List<PriceRange>> locations = (map['locations'] as Map).map((key, value) {
      List<PriceRange> listRanges = [];
      if (value is List) {
        listRanges = value.map((e) => PriceRange.fromMap(e)).toList();
      } else if (value is Map<String, dynamic>) {
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
