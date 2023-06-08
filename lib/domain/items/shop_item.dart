import 'package:cloud_firestore/cloud_firestore.dart';

class ShopItem {
  final String? name;
  final String? image;
  final String? url;
  final DateTime lastUpdate;
  final bool available;
  final double? price;

  ShopItem({
    required this.name,
    this.image,
    required this.url,
    required this.lastUpdate,
    required this.available,
    required this.price,
  });

  String get availableString  {
    if (available) {
      return "Disponible";
    } else {
      return "No Disponible";
    }
  }

  Map<String, dynamic> toMap() {
    return {
      'name': this.name,
      'image': this.image,
      'url': this.url,
      'last_update': this.lastUpdate,
      'available': this.available,
      'price': this.price,
    };
  }

  factory ShopItem.fromMap(Map<String, dynamic> map) {
    return ShopItem(
      name: map['name'] as String,
      image: map['image'] as String,
      url: map['url'] as String,
      lastUpdate: map['last_update'] as DateTime,
      available: map['available'] as bool,
      price: map['price'] as double,
    );
  }

  factory ShopItem.fromFirebase(Map<String, dynamic> map) {
    return ShopItem(
      name: map['name'] as String,
      image: map['image'] as String,
      url: map['url'] as String,
      lastUpdate: (map['last_update'] as Timestamp).toDate(),
      available: map['available'] as bool,
      price:(map['price'] as num).toDouble(),


    );
  }
}
