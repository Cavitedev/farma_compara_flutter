import 'package:farma_compara_flutter/domain/items/shop_item.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../../core/constants/app_margin_and_sizes.dart';
import '../../../../domain/items/item.dart';

class ShopBadge extends StatelessWidget {
  final MapEntry<String, ShopItem> shopItem;

  const ShopBadge({
    required this.shopItem,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final name = Item.websiteKeyToName(shopItem.key);
    final color = Item.websiteKeyToColor(shopItem.key);

    final formatter = NumberFormat.simpleCurrency(locale: Intl.getCurrentLocale());
    final price = formatter.format(shopItem.value.price);


    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Container(
        padding: const EdgeInsets.all(containerPadding),
        margin: const EdgeInsets.symmetric(horizontal: 2.0),
        decoration: BoxDecoration(
          color: color,
          borderRadius: generalBorderRadius,
          border: Border.all(color: Colors.black),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 2,
              blurRadius: 6,
              offset: const Offset(1, 2), // changes position of shadow
            ),
          ],
        ),
        child: Text(
          "$name: $price",
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
