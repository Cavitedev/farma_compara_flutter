import 'package:farma_compara_flutter/presentation/widgets/items_browse_loaded_games.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../application/browser/browser_notifier.dart';
import '../core/constants/app_margin_and_sizes.dart';

class ItemsBrowse extends ConsumerWidget {
  const ItemsBrowse({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final notifier = ref.read(browserNotifierProvider.notifier);
    final actualPage = ref.read(browserNotifierProvider).page;

    if (actualPage == 0) {
      notifier.loadItems();
    }

    return Scaffold(
        body: RefreshIndicator(
      semanticsLabel: "Recargar juegos de mesa",
      triggerMode: RefreshIndicatorTriggerMode.onEdge,
      onRefresh: () async {
        ref.read(browserNotifierProvider.notifier).clear();
      },
      child: NotificationListener<ScrollUpdateNotification>(
        onNotification: (ScrollNotification scrollInfo) {
          return _onScroll(scrollInfo, ref);
        },
        child: CustomScrollView(
          slivers: [
            SliverAppBar(
              title: Text("Farma Compara"),
            ),
            SliverPadding(
              padding: const EdgeInsets.symmetric(horizontal: listPadding),
              sliver: ItemsBrowserLoadedGames(),
            )
          ],
        ),
      ),
    ));
  }

  bool _onScroll(ScrollNotification scrollInfo, WidgetRef ref) {
    if (scrollInfo.metrics.pixels > scrollInfo.metrics.maxScrollExtent - 300 &&
        ref.read(browserNotifierProvider).isLoaded) {
      final browserNotifier = ref.read(browserNotifierProvider.notifier);

      browserNotifier.nextPageIfNotLoading();
      return true;
    }
    return false;
  }
}
