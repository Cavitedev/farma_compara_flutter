import 'package:farma_compara_flutter/application/cart/cart_notifier.dart';
import 'package:farma_compara_flutter/core/constants/app_margin_and_sizes.dart';
import 'package:farma_compara_flutter/domain/delivery/delivery_fee.dart';
import 'package:farma_compara_flutter/domain/delivery/price_range.dart';
import 'package:farma_compara_flutter/domain/items/item_utils.dart';
import 'package:farma_compara_flutter/domain/locations/locations_hierarchy.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

class DeliveryFeesList extends ConsumerWidget {
  const DeliveryFeesList({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final deliveryFees = ref.watch(cartNotifierProvider).deliveryFees;
    final entriesFees = deliveryFees.deliveryFeeMap.entries.toList();

    return SliverList(
        delegate: SliverChildBuilderDelegate((context, index) {
      final fee = entriesFees[index];
      return DeliveryFeeItem(
        deliveryFeeEntry: fee,
      );
    }, childCount: entriesFees.length));
  }
}

class DeliveryFeeItem extends StatelessWidget {
  final MapEntry<String, DeliveryFee> deliveryFeeEntry;

  const DeliveryFeeItem({
    required this.deliveryFeeEntry,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final List<Map<String, List<PriceRange>>> groupedPrices = deliveryFeeEntry.value.groupedByPrice();

    final String shopName = ItemUtils.websiteKeyToName(deliveryFeeEntry.key);
    return Padding(
      padding: const EdgeInsets.all(generalPadding),
      child: Column(
        children: [
          Text(
            shopName,
            style: Theme.of(context).textTheme.headlineMedium,
          ),
          Column(
            children: groupedPrices
                .map((fee) => DeliveryTable(
                      deliveryFees: fee.entries.toList(),
                      shopName: shopName,
                    ))
                .toList(),
          ),
        ],
      ),
    );
  }
}

class DeliveryTable extends StatelessWidget {
  final List<MapEntry<String, List<PriceRange>>> deliveryFees;
  final String shopName;

  const DeliveryTable({
    required this.deliveryFees,
    required this.shopName,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final formatter = NumberFormat.simpleCurrency(locale: Intl.getCurrentLocale());

    return Padding(
      padding: const EdgeInsets.only(top: listPadding),
      child: Table(
        border: TableBorder.all(),
        defaultVerticalAlignment: TableCellVerticalAlignment.middle,
        children: [
          TableRow(children: [
            const SizedBox.shrink(),
            ...deliveryFees.first.value.map((priceRange) {
              final minPrice = formatter.format(priceRange.min);
              final maxPrice = formatter.format(priceRange.max);

              return Text(
                priceRange.max == double.infinity ? "Desde $minPrice" : "$minPrice a $maxPrice",
                textAlign: TextAlign.center,
              );
            }).toList()
          ]),
          ...deliveryFees.map((fee) => TableRow(
                children: [
                  Text(
                    LocationsHierarchy.locationsTranslations[fee.key] ?? fee.key,
                    textAlign: TextAlign.center,
                  ),
                  ...fee.value.map((priceRange) {
                    final price = formatter.format(priceRange.price);
                    return Text(
                      price,
                      textAlign: TextAlign.center,
                    );
                  })
                ],
              )),
        ],
      ),
    );
  }
}
