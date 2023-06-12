import 'package:farma_compara_flutter/application/cart/cart_notifier.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../application/cart/cart_state.dart';
import '../../core/widgets/firestore_failure_widget.dart';

class DeliverySummary extends ConsumerWidget {
  final CartState cartState;

  const DeliverySummary({required this.cartState, super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SliverList.list(children: [
      if (cartState.failure.value != null)
        FirestoreFailureWidget(failure: cartState.failure.value!),
      ElevatedButton(
        onPressed: () {
          ref.read(cartNotifierProvider.notifier).loadDeliveryFees();
        },
        child: const Text("Refrescar Precio Envio"),
      ),

    ]);
  }
}