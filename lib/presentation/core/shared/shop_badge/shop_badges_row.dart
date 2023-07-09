import 'package:farma_compara/domain/items/item.dart';
import 'package:farma_compara/domain/items/shop_item.dart';
import 'package:farma_compara/presentation/core/shared/shop_badge/shop_badge.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../application/browser/browser_notifier.dart';

class ShopBadgesRow extends ConsumerWidget {
  final Item item;

  const ShopBadgesRow({
    required this.item,
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final shopKeysFilter = ref.watch(browserNotifierProvider).query.shopList.shopNames;

    final listWebsites =
        item.orderedWebsiteItemsByPrice().where((websiteItem) => shopKeysFilter.contains(websiteItem.key)).toList();

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
