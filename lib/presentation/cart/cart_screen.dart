import 'package:farma_compara/application/cart/cart_state.dart';
import 'package:farma_compara/domain/items/item_cart.dart';
import 'package:farma_compara/presentation/cart/widgets/delivery_summary.dart';
import 'package:farma_compara/presentation/cart/widgets/item_cart_list.dart';
import 'package:farma_compara/presentation/cart/widgets/optimize_purchase/final_summary_table.dart';
import 'package:farma_compara/presentation/cart/widgets/optimize_purchase/optimized_shop_header.dart';
import 'package:farma_compara/presentation/cart/widgets/optimize_purchase/shops_optimized_items.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../application/cart/cart_notifier.dart';
import '../../core/constants/app_constants.dart';

class CartScreen extends ConsumerStatefulWidget {
  const CartScreen({
    Key? key,
  }) : super(key: key);

  @override
  ConsumerState<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends ConsumerState<CartScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      ref.read(cartNotifierProvider.notifier).loadDeliveryFees();
    });
  }

  @override
  Widget build(BuildContext context) {
    final CartState cartState = ref.watch(cartNotifierProvider);
    final List<ItemCart> itemCartList = cartState.items;

    ref.listen(cartNotifierProvider, (previous, next) {
      if (previous == null) return;
      if (next.items.length < previous.items.length) {
        final snackBar = SnackBar(
          content: const Text('Eliminado completamente del carrito'),
          action: SnackBarAction(
            label: 'Deshacer',
            onPressed: () {
              final deletedItem = previous.items.firstWhere((element) => !next.items.contains(element)).item;
              ref.read(cartNotifierProvider.notifier).addItem(deletedItem);
            },
          ),
        );

        snackbarKey.currentState?.showSnackBar(snackBar);
      }
    });

    return Scaffold(
        body: CustomScrollView(slivers: [
      SliverAppBar(
        title: Text("Compra (${cartState.totalItems})"),
        floating: true,
      ),
      ItemCartList(itemCartList: itemCartList),
      const SliverToBoxAdapter(
        child: Divider(),
      ),
      DeliverySummary(cartState: cartState),
      const SliverToBoxAdapter(
        child: Divider(),
      ),
      const OptimizedShopHeader(),


      const ShopsOptimizedItems(),
      const FinalSummaryTable(),
      const SliverToBoxAdapter(child: SizedBox(height: 50)),
    ]));
  }
}
