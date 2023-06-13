import 'package:farma_compara_flutter/domain/delivery/delivery_fee.dart';

import '../item_cart.dart';

class PaymentOptimized {
  final Map<String, PaymentShop> shopsToPay;

//<editor-fold desc="Data Methods">
  const PaymentOptimized({
    required this.shopsToPay,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is PaymentOptimized && runtimeType == other.runtimeType && shopsToPay == other.shopsToPay);

  @override
  int get hashCode => shopsToPay.hashCode;

  @override
  String toString() {
    return 'PaymentOptimized{ shopsToPay: $shopsToPay,}';
  }

  PaymentOptimized copyWith({
    Map<String, PaymentShop>? shopsToPay,
  }) {
    return PaymentOptimized(
      shopsToPay: shopsToPay ?? this.shopsToPay,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'shopsToPay': this.shopsToPay,
    };
  }

  factory PaymentOptimized.fromMap(Map<String, dynamic> map) {
    return PaymentOptimized(
      shopsToPay: map['shopsToPay'] as Map<String, PaymentShop>,
    );
  }

//</editor-fold>
}

class PaymentShop {
  final DeliveryFee fee;
  final List<ItemCart> items;
  final String shopName;

//<editor-fold desc="Data Methods">
  const PaymentShop({
    required this.shopName,
    required this.fee,
    required this.items,
  });

  double itemsPrice(){
    return items.fold(0, (previousValue, element) => previousValue + element.item.websiteItems[shopName]!.price! * element.quantity);
  }

  // double total(){
  //   return itemsPrice() + fee.price;
  // }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is PaymentShop &&
          runtimeType == other.runtimeType &&
          fee == other.fee &&
          items == other.items &&
          shopName == other.shopName);

  @override
  int get hashCode => fee.hashCode ^ items.hashCode ^ shopName.hashCode;

  @override
  String toString() {
    return 'PaymentShop{' + ' fee: $fee,' + ' items: $items,' + ' shopName: $shopName,' + '}';
  }

  PaymentShop copyWith({
    DeliveryFee? fee,
    List<ItemCart>? items,
    String? shopName,
  }) {
    return PaymentShop(
      fee: fee ?? this.fee,
      items: items ?? this.items,
      shopName: shopName ?? this.shopName,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'fee': this.fee,
      'items': this.items,
      'shopName': this.shopName,
    };
  }

  factory PaymentShop.fromMap(Map<String, dynamic> map) {
    return PaymentShop(
      fee: map['fee'] as DeliveryFee,
      items: map['items'] as List<ItemCart>,
      shopName: map['shopName'] as String,
    );
  }

//</editor-fold>
}
