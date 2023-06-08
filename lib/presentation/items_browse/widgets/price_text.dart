import 'package:farma_compara_flutter/core/constants/custom_theme.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class PriceText extends StatelessWidget {
  const PriceText({
    required this.price,
    Key? key,
  }) : super(key: key);

  final double price;

  @override
  Widget build(BuildContext context) {
    final formatter = NumberFormat.simpleCurrency(locale: Intl.getCurrentLocale());

    return Text(formatter.format(price), style: CustomTheme.priceText(context));
  }
}
