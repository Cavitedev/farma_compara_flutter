import 'package:farma_compara/domain/items/item.dart';
import 'package:farma_compara/domain/locations/locations_hierarchy.dart';

import '../core/failure.dart';

abstract class DeliveryFailure extends Failure {
  const DeliveryFailure();

  String get msg;
}

class DeliveryFailureNotFound extends DeliveryFailure {
  final String location;

  const DeliveryFailureNotFound({required this.location});

  @override
  String get msg => "No permite envíos hacia ${LocationsHierarchy.locationsTranslations[location]}";

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is DeliveryFailureNotFound && runtimeType == other.runtimeType && location == other.location;

  @override
  int get hashCode => location.hashCode;
}

class DeliveryFailureNotAvailable extends DeliveryFailure {

  const DeliveryFailureNotAvailable();

  @override
  String get msg => "No está disponible el producto";

}

class ItemsDeliveryFailure extends Failure{
  final List<ItemDeliveryFailure> items;
  final String location;

  const ItemsDeliveryFailure({
    required this.items,
    required this.location,
  });

  bool hasFailure(){
    return items.isNotEmpty;
  }
}

class ItemDeliveryFailure{
  final Item item;
  final List<WebsiteDeliveryFailure> websites;

  const ItemDeliveryFailure({
    required this.item,
    required this.websites,
  });
}

class WebsiteDeliveryFailure {

  final String website;
  final DeliveryFailure failure;

  const WebsiteDeliveryFailure({
    required this.website,
    required this.failure,
  });
}