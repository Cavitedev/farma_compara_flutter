import 'package:farma_compara_flutter/core/constants/custom_theme.dart';
import 'package:flutter/material.dart';

class PriceText extends StatelessWidget {
  const PriceText({
    required this.price,
    Key? key,
  }) : super(key: key);

  final double price;

  @override
  Widget build(BuildContext context) {
    return Text("${price.toStringAsFixed(2)}€", style: CustomTheme.priceText(context));
  }
}
