import 'package:farma_compara_flutter/domain/core/sort_order.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../../application/browser/browser_notifier.dart';

class ItemsSort extends ConsumerStatefulWidget {
  const ItemsSort({
    Key? key,
  }) : super(key: key);

  @override
  ConsumerState<ItemsSort> createState() => _ItemsSort();
}

class _ItemsSort extends ConsumerState<ItemsSort> {
  String initOrder = categoriesUrl.keys.first;

  static Map<String, SortOrder> categoriesUrl = {
    "Orden Alfabético A->Z": SortOrder.byName(),
    "Orden Alfabético Inverso Z->A": SortOrder.byName(descending: true),
    "Más Baratos": SortOrder.byPrice(),
    "Más Caros": SortOrder.byPrice(descending: true),
    "Últimos Actualizados": SortOrder.byUpdate(descending: true),
  };

  @override
  void initState() {
    super.initState();
    final SortOrder order = ref.read(browserNotifierProvider).query.orderBy;
    initOrder = categoriesUrl.keys.firstWhere((key) => categoriesUrl[key] == order);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: Colors.grey[200],
          border: Border.all(color: Colors.grey),
          borderRadius: const BorderRadius.all(Radius.circular(5.0))),
      child: DropdownButton<String>(
        value: initOrder,
        isExpanded: true,
        alignment: Alignment.centerLeft,
        icon: const Icon(Icons.arrow_drop_down),
        underline: Container(),
        onChanged: (String? newOrder) {
          setState(() {
            initOrder = newOrder!;
          });

          ref.read(browserNotifierProvider.notifier).changeFilters(
              ref.read(browserNotifierProvider).query.copyWith(orderBy: categoriesUrl[newOrder]));
        },
        dropdownColor: Colors.grey[200],
        items: categoriesUrl.keys.map<DropdownMenuItem<String>>((String value) {
          return DropdownMenuItem<String>(
            value: value,
            child: Padding(
              padding: const EdgeInsets.only(left: 8.0),
              child: Text(
                value,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: Theme.of(context).textTheme.labelLarge,
              ),
            ),
          );
        }).toList(),
      ),
    );
  }
}
