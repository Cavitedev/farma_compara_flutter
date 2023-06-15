import 'package:farma_compara_flutter/presentation/cart/widgets/optimize_purchase/total_price_items.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/constants/app_margin_and_sizes.dart';
import 'location_dropdown.dart';

class OptimizedShopWidget extends ConsumerWidget {
  const OptimizedShopWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SliverPadding(
      padding: const EdgeInsets.symmetric(horizontal: generalPadding),
      sliver: SliverList.list(children: [
        Text(
          "Mejor Combinación",
          style: Theme.of(context).textTheme.headlineMedium,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: innerElementsPadding),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                "Envío a: ",
                style: Theme.of(context).textTheme.labelLarge,
              ),
              const Flexible(child: LocationDropdown()),
            ],
          ),
        ),
        const TotalPriceItems(),
      ]),
    );
  }
}
