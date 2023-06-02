import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../application/browser/browser_notifier.dart';
import '../../core/constants/app_margin_and_sizes.dart';
import '../../domain/items/item.dart';
import 'items_browse_sliver_list.dart';

class ItemsBrowserLoadedGames extends ConsumerWidget {
  const ItemsBrowserLoadedGames({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Consumer(
      builder: (context, ref, _) {
        final loadedGames = ref
            .watch(browserNotifierProvider)
            .items;
        return _sucessBody([...loadedGames]);
      },
    );
  }

  Widget _sucessBody(List<Item> items) {
    return Consumer(
      builder: (context, ref, _) {
        // final listOrGridView = ref.watch(listGridViewProvider);
        return SliverPadding(
            padding: const EdgeInsets.symmetric(horizontal: listPadding),
            sliver: _gamesOverviewBody(items));
      },
    );
  }

  Widget _gamesOverviewBody(List<Item> items) {
    return ItemsBrowseSliverList(
      items: items,
    );
  }
}
