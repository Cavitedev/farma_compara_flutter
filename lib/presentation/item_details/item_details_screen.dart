import 'package:cached_network_image/cached_network_image.dart';
import 'package:farma_compara/application/browser/browser_notifier.dart';
import 'package:farma_compara/presentation/item_details/widgets/item_details_other_pages_list.dart';
import 'package:farma_compara/presentation/items_browse/widgets/price_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../application/cart/cart_notifier.dart';
import '../../core/constants/app_constants.dart';
import '../../core/constants/app_margin_and_sizes.dart';
import '../../core/constants/custom_theme.dart';
import '../../domain/items/item.dart';
import '../core/shared/cart_button.dart';

class ItemDetailsScreen extends ConsumerWidget {
  final String ref;

  const ItemDetailsScreen({required this.ref, super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    Item item = ref.read(browserNotifierProvider).itemByRef(this.ref)!;
    String? itemImage = item.websiteItems.values.firstWhere((element) => element.image != null).image;

    ref.listen(cartNotifierProvider, (previous, next) {
      if (previous == null) return;
      if (next.totalItems > previous.totalItems) {
        final snackBar = SnackBar(
          content: const Text('Agregado al carrito'),
          action: SnackBarAction(
            label: 'Deshacer',
            onPressed: () {
              ref.read(cartNotifierProvider.notifier).removeItem(next.items.last.item);
            },
          ),
        );

        snackbarKey.currentState?.showSnackBar(snackBar);
      }
    });

    return Scaffold(
      body: CustomScrollView(
        slivers: [
          const SliverAppBar(
            // leading: BackButton(),
            title: Text("Detalles"),
            actions: [
              CartButton(),
            ],
            floating: true,
            pinned: true,
          ),
          SliverPadding(
            padding: const EdgeInsets.all(generalPadding),
            sliver: SliverToBoxAdapter(
              child: SelectableText(
                item.name,
                style: Theme.of(context).textTheme.headlineMedium,
                textAlign: TextAlign.center,
              ),
            ),
          ),
          SliverPadding(
            padding: const EdgeInsets.symmetric(horizontal: generalPadding, vertical: innerElementsPadding),
            sliver: SliverToBoxAdapter(
              child: SelectableText(
                "Ref: ${item.ref}",
                style: Theme.of(context).textTheme.labelLarge,
                textAlign: TextAlign.center,
              ),
            ),
          ),
          if (itemImage != null)
            SliverToBoxAdapter(
              child: CachedNetworkImage(
                imageUrl: itemImage,
                fit: BoxFit.fill,
                placeholder: (context, url) => const Center(child: CircularProgressIndicator()),
                width: 300,
                errorWidget: (BuildContext context, String url, dynamic error) =>
                    const Center(child: Icon(Icons.error_rounded)),
              ),
            ),
          SliverPadding(
            padding: const EdgeInsets.all(generalPadding),
            sliver: SliverToBoxAdapter(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Precio: ",
                    style: CustomTheme.priceText(context),
                  ),
                  PriceText(price: item.bestPrice)
                ],
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(generalPadding),
              child: ElevatedButton(
                  onPressed: item.available
                      ? () {
                          ref.read(cartNotifierProvider.notifier).addItem(item);
                        }
                      : null,
                  child: Text(item.available ? "Comprar" : "No Disponible")),
            ),
          ),
          const SliverToBoxAdapter(child: Divider()),
          ItemDetailsOtherPagesList(item: item),
          const SliverToBoxAdapter(
            child: SizedBox(
              height: 30,
            ),
          )
        ],
      ),
    );
  }
}
