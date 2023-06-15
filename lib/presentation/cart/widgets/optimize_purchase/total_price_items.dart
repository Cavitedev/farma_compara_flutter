import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../application/cart/cart_notifier.dart';
import '../../../../core/constants/custom_theme.dart';
import '../../../items_browse/widgets/price_text.dart';

class TotalPriceItems extends ConsumerWidget {
  const TotalPriceItems({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final paymentOptimized = ref.watch(cartNotifierProvider).paymentOptimized;

    if (paymentOptimized == null || paymentOptimized.isLeft()) {
      return const SizedBox.shrink();
    }
    final total = paymentOptimized.getRight()!.total();
    if (total.isLeft() || total.getRight()!.totalPrice == 0) {
      return const SizedBox.shrink();
    }

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            "Total: ",
            style: CustomTheme.priceText(context),
          ),
          PriceText(price: total.getRight()!.totalPrice)
        ],
      ),
    );
  }
}
