import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../application/browser/browser_notifier.dart';
import '../../../core/optional.dart';
import '../../../domain/items/firestore_failure.dart';
import '../../core/widgets/firestore_failure_widget.dart';
import '../../core/widgets/loading.dart';

class ItemsBrowseLoad extends ConsumerWidget {
  const ItemsBrowseLoad({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {

    bool isLoading = ref.watch(browserNotifierProvider).isLoading;
    Optional<FirestoreFailure?> failure = ref.watch(browserNotifierProvider).failure;

    if (failure.value != null) {
      return SliverToBoxAdapter(child: FirestoreFailureWidget(failure: failure.value!));
    }

    if (isLoading) {
      return const SliverToBoxAdapter(child: Loading());
    }

    return const SliverToBoxAdapter(
      child: SizedBox.shrink(),
    );
  }
}
