import 'package:cached_network_image/cached_network_image.dart';
import 'package:farma_compara_flutter/domain/items/shop_item.dart';
import 'package:farma_compara_flutter/presentation/items_browse/widgets/price_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:routemaster/routemaster.dart';

import '../../../core/constants/app_margin_and_sizes.dart';
import '../../../domain/items/item.dart';

class ItemsBrowseSliverList extends StatelessWidget {
  const ItemsBrowseSliverList({
    required this.items,
    Key? key,
  }) : super(key: key);

  final List<Item> items;

  @override
  Widget build(BuildContext context) {
    return SliverList(
      delegate: SliverChildBuilderDelegate((context, index) {
        final Item item = items[index];
        return ListItem(item: item);
      }, childCount: items.length),
    );
  }
}

class ListItem extends ConsumerWidget {
  const ListItem({
    Key? key,
    required this.item,
  }) : super(key: key);

  final Item item;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ShopItem shopItem = item.firstShopItem();

    return Stack(
      children: [
        Card(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (shopItem.image != null)
                Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: CachedNetworkImage(
                      imageUrl: shopItem.image!,
                      fit: BoxFit.fill,
                      placeholder: (context, url) => const Center(child: CircularProgressIndicator()),
                      width: 100,
                      errorWidget: (BuildContext context, String url, dynamic error) =>
                          const Center(child: Icon(Icons.error_rounded)),
                    )),
              Flexible(
                child: Semantics(
                  button: true,
                  onTapHint: "Ir a pantalla de detalles",
                  onTap: () {
                    _goDetailsPage(ref);
                  },
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Padding(
                        padding: const EdgeInsets.fromLTRB(5, 10, 0, 10),
                        child: Text(
                          item.name,
                          style: Theme.of(context).textTheme.headlineSmall,
                          maxLines: 3,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),

                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Flexible(
                                flex: 1,
                                child: Text(
                                    item.availableString
                                )),
                            Flexible(
                              flex: 1,
                              child: Padding(
                                padding: const EdgeInsets.fromLTRB(5, innerElementsPadding, 0, innerElementsPadding),
                                child: PriceText(price: item.bestPrice),
                              ),
                            ),
                          ],
                        ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
        Positioned.fill(
            child: Material(
                color: Colors.transparent,
                child: InkWell(
                  onTap: () {
                    _goDetailsPage(ref);
                  },
                ))),
      ],
    );
  }

  void _goDetailsPage(WidgetRef ref) {
    Routemaster.of(ref.context).push('item/${item.ref}');
  }
}
