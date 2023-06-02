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

    if(actualPage == 0){
      notifier.loadItems();
    }

    return Scaffold(
        body: CustomScrollView(
      slivers: [
        SliverAppBar(
          title: Text("Farma Compara"),
        ),
        SliverPadding(
          padding: const EdgeInsets.symmetric(horizontal: listPadding),
          sliver: ItemsBrowserLoadedGames(),
        )
      ],
    ));
  }
}
