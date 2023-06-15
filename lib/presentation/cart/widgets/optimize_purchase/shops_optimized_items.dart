import 'package:farma_compara_flutter/application/cart/cart_notifier.dart';
import 'package:farma_compara_flutter/domain/items/item_utils.dart';
import 'package:farma_compara_flutter/domain/items/payment_optimized/payment_optimized.dart';
import 'package:farma_compara_flutter/presentation/cart/widgets/optimize_purchase/total_price_table.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../item_cart_list.dart';

class ShopsOptimizedItems extends ConsumerWidget {
  const ShopsOptimizedItems({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final paymentOptimized = ref.watch(cartNotifierProvider).paymentOptimized;
    if (paymentOptimized == null) {
      return const SliverToBoxAdapter(child: Center(child: CircularProgressIndicator()));
    }
    if(paymentOptimized.isLeft()){
      return const SliverToBoxAdapter(child: Text("error"));
    }

    final List<PaymentShop> shops = paymentOptimized.getRight()!.shopsToPay.values.toList();

    return SliverList.builder(
      itemBuilder: (context, index) {
        final PaymentShop shop = shops[index];
        return ShopOptimizedItems(
          shop: shop,
          location: paymentOptimized.getRight()!.location,
        );
      },
      itemCount: shops.length,
    );
  }
}

class ShopOptimizedItems extends StatelessWidget {
  const ShopOptimizedItems({
    super.key,
    required this.shop,
    required this.location,
  });

  final PaymentShop shop;
  final String location;

  @override
  Widget build(BuildContext context) {
    final shopName = ItemUtils.websiteKeyToName(shop.shopName);
    final total = shop.total(location);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(shopName, style: Theme.of(context).textTheme.headlineSmall, textAlign: TextAlign.center),
        ListView.builder(
          shrinkWrap: true,
          padding: EdgeInsets.zero,
          physics: const NeverScrollableScrollPhysics(),
          itemBuilder: (context, index) {
            final item = shop.items[index];
            return ItemCartDetail(itemCart: item, shopName: shop.shopName);
          },
          itemCount: shop.items.length,
        ),
        total.when((left) => const Text("No se pudo cargar el total"), (right) => TotalPriceTable(totalPrice: right)),
      ],
    );
  }
}
