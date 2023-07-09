import 'package:farma_compara/application/browser/browser_notifier.dart';
import 'package:farma_compara/application/cart/cart_notifier.dart';
import 'package:farma_compara/core/constants/app_margin_and_sizes.dart';
import 'package:farma_compara/domain/items/item_utils.dart';
import 'package:farma_compara/presentation/items_browse/widgets/items_browse_sliver_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../domain/delivery/delivery_failure.dart';

class ItemsDeliveryFailureWidget extends StatelessWidget {
  const ItemsDeliveryFailureWidget({
    super.key,
    required this.failure,
  });

  final ItemsDeliveryFailure failure;

  @override
  Widget build(BuildContext context) {
    return SliverList.builder(
        itemBuilder: (context, i) {
          final item = failure.items[i];
          return ItemDeliveryFailureWidget(failure: item);
        },
        itemCount: failure.items.length);
  }
}

class ItemDeliveryFailureWidget extends StatelessWidget {
  const ItemDeliveryFailureWidget({
    super.key,
    required this.failure,
  });

  final ItemDeliveryFailure failure;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListItem(item: failure.item),
        ...failure.websites.map((e) => WebsiteFailure(websiteDeliveryFailure: e))
      ],
    );
  }
}

class WebsiteFailure extends ConsumerWidget {
  const WebsiteFailure({
    super.key,
    required this.websiteDeliveryFailure,
  });

  final WebsiteDeliveryFailure websiteDeliveryFailure;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final pageName = ItemUtils.websiteKeyToName(websiteDeliveryFailure.website);
    final pageColor = ItemUtils.websiteKeyToColor(websiteDeliveryFailure.website);

    return Card(
      color: pageColor,
      elevation: 2,
      surfaceTintColor: pageColor,
      child: Padding(
        padding: const EdgeInsets.all(innerElementsPadding),
        child: Row(
          children: [
            Text("$pageName: "),
            Flexible(child: Wrap(children: [Text(websiteDeliveryFailure.failure.msg),
            if(websiteDeliveryFailure.failure is DeliveryFailureDisabled)
              ElevatedButton(onPressed: () {
                ref.read(browserNotifierProvider.notifier).reenableWebsite(websiteDeliveryFailure.website);
                ref.read(cartNotifierProvider.notifier).calculateOptimizedPrices();
              }, child: const Text("rehabilitar"))

            ]))
          ],
        ),
      ),
    );
  }
}
