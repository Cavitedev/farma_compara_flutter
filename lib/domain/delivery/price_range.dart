class PriceRange {
  double min;
  double max;
  double fee;

  PriceRange({
    this.min = 0,
    required this.max,
    required this.fee,
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
      'fee': this.fee,
    };
  }

  factory PriceRange.fromMap(Map<String, dynamic> map) {
    return PriceRange(
      min: map['min'] as double,
      max: map['max'] as double,
      fee: map['fee'] as double,
    );
  }
}
