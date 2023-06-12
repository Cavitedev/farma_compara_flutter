import 'package:farma_compara_flutter/application/cart/cart_notifier.dart';
import 'package:farma_compara_flutter/presentation/item_details/item_details_screen.dart';
import 'package:farma_compara_flutter/presentation/items_browse/items_browse_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:routemaster/routemaster.dart';

import '../presentation/cart/cart_screen.dart';

RouteMap buildRoutes(BuildContext context, WidgetRef ref) {
  return RouteMap(routes: {
    '/': (_) => const MaterialPage<void>(child: ItemsBrowseScreen()),
    '/item/:ref': (route) => MaterialPage<void>(
          child: ItemDetailsScreen(
            ref: route.pathParameters['ref']!,
          ),
        ),
    '/cart': (route) {
      ref.read(cartNotifierProvider.notifier).loadDeliveryFees();
      return const MaterialPage<void>(
        child: CartScreen(),
      );
    },
  });
}
