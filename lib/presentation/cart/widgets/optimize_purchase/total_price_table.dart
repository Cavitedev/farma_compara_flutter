import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../../core/constants/app_margin_and_sizes.dart';
import '../../../../domain/items/payment_optimized/total_price.dart';
import '../../../core/widgets/table_padding.dart';

class TotalPriceTable extends StatelessWidget {
  const TotalPriceTable({
    super.key,
    required this.totalPrice,
  });

  final TotalPrice totalPrice;

  @override
  Widget build(BuildContext context) {
    final formatter = NumberFormat.simpleCurrency(locale: Intl.getCurrentLocale());

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: generalPadding),
      child: Table(
        border: TableBorder.all(width: 2),
        children: [
          _buildTableRow("Precio Productos:", totalPrice.itemsPrice, formatter),
          _buildTableRow("Precio Envío:", totalPrice.feeCost, formatter),
          _buildTableRow("Precio Total:", totalPrice.totalPrice, formatter),
        ],
      ),
    );
  }

  TableRow _buildTableRow(String label, double price, NumberFormat formatter) {
    return TableRow(children: [
      TablePadding(
        child: Text(label),
      ),
      TablePadding(
        child: Text(formatter.format(price), textAlign: TextAlign.right),
      ),
    ]);
  }
}
