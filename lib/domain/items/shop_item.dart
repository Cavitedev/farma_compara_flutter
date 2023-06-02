class ShopItem {
  final String name;
  final String img;
  final String url;
  final DateTime lastUpdate;
  final bool available;
  final double price;

  ShopItem({
    required this.name,
    required this.img,
    required this.url,
    required this.lastUpdate,
    required this.available,
    required this.price,
  });

  Map<String, dynamic> toMap() {
    return {
      'name': this.name,
      'img': this.img,
      'url': this.url,
      'lastUpdate': this.lastUpdate,
      'available': this.available,
      'price': this.price,
    };
  }

  factory ShopItem.fromMap(Map<String, dynamic> map) {
    return ShopItem(
      name: map['name'] as String,
      img: map['img'] as String,
      url: map['url'] as String,
      lastUpdate: map['lastUpdate'] as DateTime,
      available: map['available'] as bool,
      price: map['price'] as double,
    );
  }
}
