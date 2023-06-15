import 'package:farma_compara_flutter/application/cart/cart_notifier.dart';
import 'package:farma_compara_flutter/core/constants/app_margin_and_sizes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:routemaster/routemaster.dart';

import '../../../application/cart/cart_state.dart';
import '../../../domain/items/firestore_failure.dart';
import '../../core/widgets/firestore_failure_widget.dart';

class DeliverySummary extends ConsumerWidget {
  final CartState cartState;

  const DeliverySummary({required this.cartState, super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SliverPadding(
      padding: const EdgeInsets.symmetric(horizontal: generalPadding),
      sliver: SliverList.list(children: [
        if (cartState.failure.isValid)
          if (cartState.failure.value is FirestoreFailure) ...[
            FirestoreFailureWidget(failure: cartState.failure.value),
            ElevatedButton(
              onPressed: () {
                ref.read(cartNotifierProvider.notifier).loadDeliveryFees();
              },
              child: const Text("Refrescar Precio Envío"),
            )
          ],

        ElevatedButton(
          onPressed: () {
            Routemaster.of(context).push("/delivery_fees");
          },
          child: const Text("Ver Precio Envío"),
        )

      ]),
    );
  }
}
