import 'package:farma_compara/presentation/delivery_fees/widgets/delivery_fees_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class DeliveryFeesScreen extends ConsumerWidget {
  const DeliveryFeesScreen({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return const Scaffold(
        body: CustomScrollView(slivers: [
      SliverAppBar(
        title: Text("Precios de envío"),
        floating: true,
      ),
      DeliveryFeesList(),
    ]));
  }
}
