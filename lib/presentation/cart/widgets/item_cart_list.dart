import 'package:cached_network_image/cached_network_image.dart';
import 'package:farma_compara_flutter/domain/items/item_cart.dart';
import 'package:farma_compara_flutter/presentation/cart/widgets/update_count_cart.dart';
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

  const ItemCartDetail({required this.itemCart, super.key});

  @override
  Widget build(BuildContext context) {
    final item = itemCart.item;
    return Card(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
              padding: const EdgeInsets.all(8.0),
              child: CachedNetworkImage(
                imageUrl: itemCart.item.image,
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
                            child: PriceText(price: item.bestPrice),
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
    );
  }
}
