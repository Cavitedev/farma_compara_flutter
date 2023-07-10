import 'package:farma_compara/domain/items/item_utils.dart';
import 'package:farma_compara/domain/items/shop_list.dart';
import 'package:farma_compara/presentation/items_browse/widgets/filters/checkbox_list_filter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../application/browser/browser_notifier.dart';
import '../../../../core/constants/app_margin_and_sizes.dart';

class FiltersPage extends Page<void> {
  @override
  Route<void> createRoute(BuildContext context) {
    return DialogRoute(
      context: context,
      builder: (context) => const FiltersDialog(),
      settings: this,
    );
  }
}

class FiltersDialog extends ConsumerStatefulWidget {
  const FiltersDialog({super.key});

  @override
  ConsumerState createState() => _FiltersDialogState();
}

class _FiltersDialogState extends ConsumerState<FiltersDialog> {
  late List<String> shopNames;

  @override
  void initState() {
    super.initState();
    shopNames = List.from(ref.read(browserNotifierProvider).query.shopList.shopNames);
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      insetPadding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
      child: Column(
        children: [
          Expanded(
            child: CheckboxListFilter(
              filterName: "Páginas a utilizar",
              categories: ItemUtils.shopNamesList,
              initialCategories: shopNames.map((key) => ItemUtils.websiteKeyToName(key)).toList(),
              onChange: (shops) {
                shopNames = shops;
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(generalPadding),
            child: Align(
              alignment: Alignment.centerRight,
              child: Wrap(
                children: [
                  ElevatedButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: const Text("Cancelar"),
                  ),
                  const SizedBox(
                    width: 20,
                  ),
                  ElevatedButton(
                      onPressed: () {
                        final List<String> shopKeys =
                            shopNames.map((name) => ItemUtils.websiteNameToKey(name)).toList();

                        ref.read(browserNotifierProvider.notifier).changeFilters(
                              ref.read(browserNotifierProvider).query.copyWith(
                                    shopList: ShopList(shopNames: shopKeys),
                                  ),
                            );
                        Navigator.pop(context);
                      },
                      child: const Text("Aceptar"))
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
