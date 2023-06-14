import 'package:farma_compara_flutter/domain/items/item.dart';
import 'package:farma_compara_flutter/domain/items/shop_item.dart';
import 'package:farma_compara_flutter/presentation/core/shared/shop_badge/shop_badge.dart';
import 'package:flutter/material.dart';

class ShopBadgesRow extends StatelessWidget {
  final Item item;

  const ShopBadgesRow({
    required this.item,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final listWebsites = item.orderedWebsiteItemsByPrice();

    return Container(
        height: 70,
        padding: const EdgeInsets.symmetric(vertical: 8.0),

        child: ListView.builder(

            itemBuilder: (context, index) {
              final MapEntry<String, ShopItem> shopItem = listWebsites[index];
              return ShopBadge(shopItem: shopItem);
            },
            shrinkWrap: true,
            physics: const BouncingScrollPhysics(),
            itemCount: listWebsites.length,

            scrollDirection: Axis.horizontal),
        );
  }
}
