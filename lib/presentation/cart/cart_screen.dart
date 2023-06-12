import 'package:farma_compara_flutter/domain/items/item_cart.dart';
import 'package:farma_compara_flutter/presentation/cart/widgets/item_cart_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../application/cart/cart_notifier.dart';
import '../../core/constants/app_constants.dart';
import '../../core/constants/custom_theme.dart';
import '../items_browse/widgets/price_text.dart';

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
    final cartState = ref.watch(cartNotifierProvider);
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

          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Total: ",
                    style: CustomTheme.priceText(context),
                  ),
                  PriceText(price: cartState.totalPrice())
                ],
              ),
            ),
          )
    ]));
  }
}
