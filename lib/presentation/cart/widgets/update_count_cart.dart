import 'package:farma_compara/domain/items/item_cart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../application/cart/cart_notifier.dart';

class UpdateCountCart extends ConsumerWidget {
  final ItemCart itemCart;

  const UpdateCountCart({
    required this.itemCart,
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Row(
      children: [
        IconButton(onPressed: () {
          ref.read(cartNotifierProvider.notifier).removeItem(itemCart.item);

        }, icon: const Icon(Icons.chevron_left)),
        Text(itemCart.quantity.toString()),
        IconButton(onPressed: () {
          ref.read(cartNotifierProvider.notifier).addItem(itemCart.item);
        }, icon: const Icon(Icons.chevron_right)),
      ],
    );
  }
}
