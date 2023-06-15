import 'package:farma_compara_flutter/core/constants/app_margin_and_sizes.dart';
import 'package:farma_compara_flutter/presentation/cart/widgets/optimize_purchase/total_price_table.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../application/cart/cart_notifier.dart';

class FinalSummaryTable extends ConsumerWidget {
  const FinalSummaryTable({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final paymentOptimized = ref.watch(cartNotifierProvider).paymentOptimized;

    if (paymentOptimized == null || paymentOptimized.isLeft()) {
      return const SliverToBoxAdapter(child: SizedBox.shrink());
    }

    final total = paymentOptimized.getRight()!.total();
    if (total.isLeft() || total.getRight()!.totalPrice == 0) {
      return const SliverToBoxAdapter(child: SizedBox.shrink());
    }

    return SliverList.list(children: [
      Padding(
        padding: const EdgeInsets.symmetric(vertical: generalPadding),
        child: Text("Total", style: Theme.of(context).textTheme.headlineSmall, textAlign: TextAlign.center),
      ),
      TotalPriceTable(totalPrice: total.getRight()!)
    ]);
  }
}
