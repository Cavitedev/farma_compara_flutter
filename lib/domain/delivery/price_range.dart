class PriceRange {
  double min;
  double max;
  double price;

  PriceRange({
    this.min = 0,
    this.max = 0,
    required this.price,
  }) {
    if (max == 0) {
      max = double.infinity;
    }
  }

  bool isInRange(double price) {
    return price >= min && price <= max;
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is PriceRange &&
          runtimeType == other.runtimeType &&
          min == other.min &&
          max == other.max &&
          price == other.price;

  @override
  int get hashCode => min.hashCode ^ max.hashCode ^ price.hashCode;

  Map<String, dynamic> toMap() {
    return {
      'min': min,
      'max': max,
      'price': price,
    };
  }

  factory PriceRange.fromMap(Map<String, dynamic> map) {
    return PriceRange(
      min: map['min'] as double? ?? 0,
      max: map['max'] as double? ?? 0,
      price: map['price'] as double,
    );
  }
}
