import 'package:farma_compara_flutter/domain/locations/locations_hierarchy.dart';
import 'package:farma_compara_flutter/presentation/core/widgets/format_widgets/error_text_with_image.dart';
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

    if (paymentOptimized == null) {
      return const SizedBox.shrink();
    }
    if (paymentOptimized.isLeft()) {
      final locationKey = paymentOptimized.getLeft()!.location;
      final locationName = LocationsHierarchy.locationsTranslations[locationKey]!;
      return ErrorTextWithImage(
          msg: "No se pueden envíar todos los productos a $locationName",
          image: "assets/images/undraw_delivery_address_re_cjca.svg");
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
