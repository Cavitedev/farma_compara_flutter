import 'package:farma_compara_flutter/presentation/item_details/item_details_screen.dart';
import 'package:farma_compara_flutter/presentation/items_browse/items_browse_screen.dart';
import 'package:flutter/material.dart';

import 'package:routemaster/routemaster.dart';

import '../presentation/cart/cart_screen.dart';

final RouteMap routerMap = RouteMap(
    routes: {
      '/': (_) => const MaterialPage<void>(child: ItemsBrowseScreen()),
      '/item/:ref': (route) => MaterialPage<void>(
        child: ItemDetailsScreen(
          ref: route.pathParameters['ref']!,
        ),
      ),

      '/cart': (route) => const MaterialPage<void>(
        child: CartScreen(),
      ),
    }
);
