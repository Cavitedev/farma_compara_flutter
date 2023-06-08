import 'package:flutter/material.dart';

import '../../../../core/constants/app_margin_and_sizes.dart';
import 'items_sort.dart';


class HeaderRow extends StatelessWidget {
  const HeaderRow({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const SliverToBoxAdapter(
      child: Padding(
        padding: EdgeInsets.fromLTRB(listPadding, 2, listPadding, 0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Flexible(
              child: ItemsSort(),
            ),

          ],
        ),
      ),
    );
  }
}
