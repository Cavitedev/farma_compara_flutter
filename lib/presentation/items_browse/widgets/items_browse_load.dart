import 'package:farma_compara_flutter/application/browser/browser_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../application/browser/browser_notifier.dart';
import '../../../core/optional.dart';
import '../../../domain/items/firestore_failure.dart';
import '../../core/widgets/firestore_failure_widget.dart';
import '../../core/widgets/format_widgets/info_text_with_image.dart';
import '../../core/widgets/loading.dart';

class ItemsBrowseLoad extends ConsumerWidget {
  const ItemsBrowseLoad({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {

    BrowserState state = ref.watch(browserNotifierProvider);

    bool isLoading = state.isLoading;
    Optional<FirestoreFailure?> failure = state.failure;

    if (failure.isValid) {
      return SliverToBoxAdapter(child: FirestoreFailureWidget(failure: failure.value!));
    }

    if (isLoading) {
      return const SliverToBoxAdapter(child: Loading());
    }

    if(state.isLoaded && state.items.isEmpty){
      return const SliverToBoxAdapter(
          child: InfoTextWithImage(
            msg: 'No hay productos que concuerden con la búsqueda',
            image: 'assets/images/undraw_not_found_re_bh2e.svg',
          )
      );
    }

    if(state.allItemsFetched){
      return const SliverToBoxAdapter(
        child: InfoTextWithImage(
          msg: 'Has llegado al ultimo producto',
          image: 'assets/images/undraw_completed_03xt.svg',
        )
      );
    }

    return const SliverToBoxAdapter(
      child: SizedBox.shrink(),
    );
  }
}
