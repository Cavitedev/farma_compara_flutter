import 'package:cloud_firestore/cloud_firestore.dart';

class WebsiteItem {
  final String? name;
  final String? image;
  final String? url;
  final DateTime lastUpdate;
  final bool available;
  final double? price;

  WebsiteItem({
    required this.name,
    this.image,
    required this.url,
    required this.lastUpdate,
    required this.available,
    required this.price,
  });

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

  factory WebsiteItem.fromMap(Map<String, dynamic> map) {
    return WebsiteItem(
      name: map['name'] as String,
      image: map['image'] as String,
      url: map['url'] as String,
      lastUpdate: map['last_update'] as DateTime,
      available: map['available'] as bool,
      price: map['price'] as double,
    );
  }

  factory WebsiteItem.fromFirebase(Map<String, dynamic> map) {
    return WebsiteItem(
      name: map['name'] as String,
      image: map['image'] as String,
      url: map['url'] as String,
      lastUpdate: (map['last_update'] as Timestamp).toDate(),
      available: map['available'] as bool,
      price: map['price'] as double,


    );
  }
}
