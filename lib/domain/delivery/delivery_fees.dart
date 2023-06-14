import 'package:farma_compara_flutter/domain/delivery/delivery_fee.dart';

class DeliveryFees{

  final Map<String, DeliveryFee> deliveryFeeMap;

//<editor-fold desc="Data Methods">
  const DeliveryFees({
    required this.deliveryFeeMap,
  });

  DeliveryFees.init(): deliveryFeeMap = {};

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is DeliveryFees && runtimeType == other.runtimeType && deliveryFeeMap == other.deliveryFeeMap);

  @override
  int get hashCode => deliveryFeeMap.hashCode;

  @override
  String toString() {
    return 'DeliveryFees{' + ' deliveryFeeMap: $deliveryFeeMap,' + '}';
  }

  DeliveryFees copyWith({
    Map<String, DeliveryFee>? deliveryFeeMap,
  }) {
    return DeliveryFees(
      deliveryFeeMap: deliveryFeeMap ?? this.deliveryFeeMap,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'deliveryFeeMap': this.deliveryFeeMap,
    };
  }

  factory DeliveryFees.fromMap(Map<String, dynamic> map) {
    return DeliveryFees(
      deliveryFeeMap: map['deliveryFeeMap'] as Map<String, DeliveryFee>,
    );
  }

//</editor-fold>
}