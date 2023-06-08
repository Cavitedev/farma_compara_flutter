import 'package:farma_compara_flutter/domain/items/item_cart.dart';
import 'package:farma_compara_flutter/presentation/cart/widgets/item_cart_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../application/cart/cart_notifier.dart';
import '../../core/constants/app_constants.dart';

class CartScreen extends ConsumerWidget {
  const CartScreen({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {

    final List<ItemCart> itemCartList = ref.watch(cartNotifierProvider).items;

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
      const SliverAppBar(
        title: Text("Compra Seleccionada"),
        floating: true,
      ),

          ItemCartList(itemCartList: itemCartList)

    ]));
  }
}
