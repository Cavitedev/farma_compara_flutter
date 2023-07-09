import 'package:farma_compara/presentation/delivery_fees/delivery_fees_screen.dart';
import 'package:farma_compara/presentation/item_details/item_details_screen.dart';
import 'package:farma_compara/presentation/items_browse/items_browse_screen.dart';
import 'package:farma_compara/presentation/items_browse/widgets/filters/filters_dialog.dart';
import 'package:flutter/material.dart';

import 'package:routemaster/routemaster.dart';

import '../presentation/cart/cart_screen.dart';

final RouteMap routerMap = RouteMap(routes: {
  '/': (_) => const MaterialPage<void>(
        child: ItemsBrowseScreen(),

      ),
  '/filters': (_) => FiltersPage(),
  '/item/:ref': (route) => MaterialPage<void>(
        child: ItemDetailsScreen(
          ref: route.pathParameters['ref']!,
        ),
      ),
  '/cart': (route) => const MaterialPage<void>(
        child: CartScreen(),
      ),
  '/delivery_fees': (route) => const MaterialPage<void>(
        child: DeliveryFeesScreen(),
      ),
});
