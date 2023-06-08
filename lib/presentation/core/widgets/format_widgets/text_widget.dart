import 'package:flutter/material.dart';


import '../../../../core/constants/app_margin_and_sizes.dart';

class TextWidget extends StatelessWidget {

  final Color color;
  final String msg;

  const TextWidget({
    required this.msg,
    required this.color,
    Key? key,
  }) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(containerPadding),
      decoration: BoxDecoration(
        color: color,
        borderRadius: generalBorderRadius,
      ),
      child: SelectableText(
        msg,
      ),
    );
  }
}
