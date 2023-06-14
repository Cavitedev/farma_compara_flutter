import 'package:farma_compara_flutter/core/either.dart';
import 'package:farma_compara_flutter/domain/core/i_cloneable.dart';
import 'package:farma_compara_flutter/domain/core/utils.dart';
import 'package:farma_compara_flutter/domain/delivery/delivery_failure.dart';
import 'package:farma_compara_flutter/domain/delivery/delivery_fee.dart';

import '../item_cart.dart';

class PaymentOptimized {
  final Map<String, PaymentShop> shopsToPay;
  final String location;

  const PaymentOptimized({
    required this.shopsToPay,
    required this.location,
  });

  Either<DeliveryFailure, double> total() {
    double totalGroup = 0;

    for (final shop in shopsToPay.values) {
      final total = shop.total(location);

      if (total.isLeft()) {
        return total;
      } else {
        totalGroup += total.getRight()!;
      }
    }
    return Right(totalGroup);
  }

//<editor-fold desc="Data Methods">
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is PaymentOptimized &&
          runtimeType == other.runtimeType &&
          shopsToPay == other.shopsToPay &&
          location == other.location);

  @override
  int get hashCode => shopsToPay.hashCode ^ location.hashCode;

  @override
  String toString() {
    return 'PaymentOptimized{' + ' shopsToPay: $shopsToPay,' + ' location: $location,' + '}';
  }

  PaymentOptimized copyWith({
    Map<String, PaymentShop>? shopsToPay,
    String? location,
  }) {
    return PaymentOptimized(
      shopsToPay: shopsToPay ?? this.shopsToPay,
      location: location ?? this.location,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'shopsToPay': this.shopsToPay,
      'location': this.location,
    };
  }

  factory PaymentOptimized.fromMap(Map<String, dynamic> map) {
    return PaymentOptimized(
      shopsToPay: map['shopsToPay'] as Map<String, PaymentShop>,
      location: map['location'] as String,
    );
  }

//</editor-fold>
}

class PaymentShop implements ICloneable<PaymentShop> {
  final DeliveryFee fee;
  final List<ItemCart> items;
  final String shopName;

//<editor-fold desc="Data Methods">
  const PaymentShop({
    required this.shopName,
    required this.fee,
    required this.items,
  });

  double itemsPrice() {
    return items.fold(
        0, (previousValue, element) => previousValue + element.item.websiteItems[shopName]!.price! * element.quantity);
  }

  Either<DeliveryFailure, double> total(String location) {
    final itemsPrice = this.itemsPrice();
    final Either<DeliveryFailure, double> feeCost = fee.priceFromCost(location, itemsPrice);

    return feeCost.when((left) => Left(left), (right) => Right(itemsPrice + right));
  }



  @override
  PaymentShop clone() {
    return PaymentShop(shopName: shopName, fee: fee, items: (Utils.deepCopy(items) as List<dynamic>).cast<ItemCart>() );
  }

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
