import 'package:farma_compara_flutter/core/date_time_extension.dart';
import 'package:farma_compara_flutter/domain/items/shop_item.dart';

import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../domain/items/item.dart';
import '../../items_browse/widgets/price_text.dart';

class ItemDetailsOtherPagesList extends StatelessWidget {
  final Item item;

  const ItemDetailsOtherPagesList({
    required this.item,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final List<MapEntry<String, ShopItem>> websiteItems = item.websiteItems.entries.toList();
    websiteItems.sort((a, b) => (a.value.price ?? 1000).compareTo(b.value.price ?? 1000));

    return SliverList(
        delegate: SliverChildBuilderDelegate((context, index) {
      final item = websiteItems[index];
      return WebsiteItemDetail(websiteItem: item);
    }, childCount: websiteItems.length));
  }
}

class WebsiteItemDetail extends StatelessWidget {
  final MapEntry<String, ShopItem> websiteItem;

  const WebsiteItemDetail({required this.websiteItem, super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Card(
          child: Column(
            children: [
              Text(Item.websiteKeyToName(websiteItem.key)),
              ListTile(
                title: Text(websiteItem.value.name!),
                subtitle: Text(websiteItem.value.availableString),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  if (websiteItem.value.image != null)
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Image.network(
                        websiteItem.value.image!,
                        fit: BoxFit.fill,
                        width: 100,
                        errorBuilder: (BuildContext context, Object exception, StackTrace? stackTrace) {
                          return const Center(child: Icon(Icons.error_rounded));
                        },
                      ),
                    ),
                  PriceText(price: websiteItem.value.price!),
                ],
              ),
              Text("Última Actualización: ${websiteItem.value.lastUpdate.toLocal().toDateAndMinutesTimeString()}")
            ],
          ),
        ),
        if (websiteItem.value.url != null)
          Positioned.fill(
              child: Material(
                  color: Colors.transparent,
                  child: InkWell(
                    onTap: () {
                      launchUrl(Uri.parse(websiteItem.value.url!));
                    },
                  )))
      ],
    );
  }
}
