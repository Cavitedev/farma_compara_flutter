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

  Map<String, dynamic> toMap() {
    return {
      'min': this.min,
      'max': this.max,
      'price': this.price,
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
