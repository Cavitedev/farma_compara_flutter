import 'package:farma_compara_flutter/presentation/widgets/items_browse_sliver_list.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../core/constants/app_margin_and_sizes.dart';
import '../domain/items/item.dart';
import '../domain/items/shop_item.dart';

class ItemsBrowse extends StatelessWidget {
  ItemsBrowse({Key? key}) : super(key: key);

  final Item item1 = Item(ref: "1", shopItems: [
    ShopItem(name: "Name", img: "https://www.dosfarma.com/3981-large_default/pinzas-automaticas-duply-beter.jpg", url: "url", lastUpdate: DateTime(2023), available: false, price: 9.99)
  ]);

  final Item item2 = Item(ref: "1", shopItems: [
    ShopItem(name: "Name", img: "https://www.dosfarma.com/23013-large_default/interapothek-gel-centella-asiatica-125ml.jpg", url: "url", lastUpdate: DateTime(2023), available: false, price: 9.99)
  ]);

  @override
  Widget build(BuildContext context) {
    final List<Item> items = [item1, item2];

    return Scaffold(
        body: CustomScrollView(
      slivers: [
        SliverAppBar(
          title: Text("Farma Compara"),
        ),
        SliverPadding(
          padding: const EdgeInsets.symmetric(horizontal: listPadding),
          sliver: ItemsBrowseSliverList(items: items),
        )
      ],
    ));
  }
}
