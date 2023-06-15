import 'package:farma_compara_flutter/domain/items/item.dart';

import '../core/failure.dart';

abstract class DeliveryFailure extends Failure {
  const DeliveryFailure();

  String get msg;
}

class DeliveryFailureNotFound extends DeliveryFailure {
  final String location;

  const DeliveryFailureNotFound({required this.location});

  @override
  String get msg => "No se han encontrado datos de envío para $location";

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

  const ItemsDeliveryFailure({
    required this.items,
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