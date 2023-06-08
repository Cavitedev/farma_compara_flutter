import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CartScreen extends ConsumerWidget {
  const CartScreen({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
        body: CustomScrollView(slivers: [
      const SliverAppBar(
        title: Text("Compra Seleccionada"),
        floating: true,
      ),

    ]));
  }
}
