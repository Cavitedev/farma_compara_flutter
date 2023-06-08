import 'package:farma_compara_flutter/presentation/items_browse/widgets/header_row/header_row.dart';
import 'package:farma_compara_flutter/presentation/items_browse/widgets/items_browse_load.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../application/browser/browser_notifier.dart';
import '../../core/constants/app_margin_and_sizes.dart';
import 'widgets/items_browse_loaded_items.dart';
import 'widgets/items_browse_sliver_app_bar.dart';

class ItemsBrowseScreen extends ConsumerStatefulWidget {
  const ItemsBrowseScreen({
    Key? key,
  }) : super(key: key);

  @override
  ConsumerState createState() => _ItemsBrowseScreenState();
}

class _ItemsBrowseScreenState extends ConsumerState<ItemsBrowseScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      final notifier = ref.read(browserNotifierProvider.notifier);
      final actualPage = ref.read(browserNotifierProvider).query.page;

      if (actualPage == 0) {
        notifier.loadItems();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
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
        child: const CustomScrollView(
          slivers: [
            ItemsBrowseSliverAppBar(),
            HeaderRow(),
            SliverPadding(
              padding: EdgeInsets.symmetric(horizontal: listPadding),
              sliver: ItemsBrowserLoadedItems(),
            ),
            ItemsBrowseLoad()
            //Fills the rest of the screen for detecting scrolls for loading
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
