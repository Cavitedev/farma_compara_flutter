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
}
