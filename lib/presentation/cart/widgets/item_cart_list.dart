import 'package:cached_network_image/cached_network_image.dart';
import 'package:farma_compara/domain/items/item_cart.dart';
import 'package:farma_compara/domain/items/item_utils.dart';
import 'package:farma_compara/presentation/cart/widgets/update_count_cart.dart';
import 'package:farma_compara/presentation/core/shared/shop_badge/shop_badges_row.dart';
import 'package:flutter/material.dart';

import '../../../core/constants/app_margin_and_sizes.dart';
import '../../items_browse/widgets/price_text.dart';

class ItemCartList extends StatelessWidget {
  final List<ItemCart> itemCartList;

  const ItemCartList({
    required this.itemCartList,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SliverList(
        delegate: SliverChildBuilderDelegate((context, index) {
      final item = itemCartList[index];
      return ItemCartDetail(itemCart: item);
    }, childCount: itemCartList.length));
  }
}

class ItemCartDetail extends StatelessWidget {
  final ItemCart itemCart;
  final String? shopName;

  const ItemCartDetail({
    required this.itemCart,
    this.shopName,
    super.key,
  });

  @override
  Widget build(BuildContext context) {

    final double price = shopName != null ? itemCart.item.websiteItems[shopName!]!.price! : itemCart.item.bestPrice;

    final item = itemCart.item;


    return Padding(
      padding: const EdgeInsets.all(listPadding),
      child: Card(
        color: shopName != null ? ItemUtils.websiteKeyToColor(shopName!) : null,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (itemCart.item.image != null)
                  Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: CachedNetworkImage(
                        imageUrl: itemCart.item.image!,
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
                      // _goDetailsPage(ref);
                    },
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Container(
                          padding: const EdgeInsets.fromLTRB(5, 10, 0, 10),
                          constraints: const BoxConstraints(minHeight: 68),
                          child: Text(
                            item.name,
                            style: Theme.of(context).textTheme.titleMedium,
                            maxLines: 3,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(5, 0, 10, 0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              UpdateCountCart(itemCart: itemCart),
                              Flexible(
                                flex: 1,
                                child: Padding(
                                  padding: const EdgeInsets.fromLTRB(5, innerElementsPadding, 0, innerElementsPadding),
                                  child: PriceText(price: price),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                )
              ],
            ),
            ShopBadgesRow(item: item)
          ],
        ),
      ),
    );
  }
}
