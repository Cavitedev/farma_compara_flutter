abstract class DeliveryFailure {
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
