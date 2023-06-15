import 'package:badges/badges.dart' as badges;
import 'package:farma_compara/application/cart/cart_state.dart';
import 'package:flutter/material.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:routemaster/routemaster.dart';

import '../../../application/cart/cart_notifier.dart';

class CartButton extends ConsumerWidget {
  const CartButton({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    CartState cart = ref.watch(cartNotifierProvider);

    return Padding(
      padding: const EdgeInsets.only(right: 2),
      child: badges.Badge(
        badgeContent: Text(cart.totalItems.toString(), style: const TextStyle(color: Colors.white, fontSize: 8)),
        position: badges.BadgePosition.topEnd(top: 0, end: 0),
        showBadge: cart.items.isNotEmpty,
        badgeAnimation: const badges.BadgeAnimation.slide(),
        child: IconButton(
          onPressed: () {
            Routemaster.of(context).push("/cart");
          },
          icon: const Icon(Icons.shopping_cart),
          tooltip: "Carrito"
        ),
      ),
    );
  }
}
