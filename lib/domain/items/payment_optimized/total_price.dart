class TotalPrice{

  final double itemsPrice;
  final double feeCost;
  final double totalPrice;

  const TotalPrice({
    required this.itemsPrice,
    required this.feeCost,
  }): totalPrice = itemsPrice + feeCost;
}