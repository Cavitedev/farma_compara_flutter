import 'package:farma_compara_flutter/core/constants/app_margin_and_sizes.dart';
import 'package:flutter/material.dart';

class TablePadding extends StatelessWidget {
  const TablePadding({
    super.key,
    required this.child,
  });

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: innerTablePadding),
      child: child,
    );
  }
}
