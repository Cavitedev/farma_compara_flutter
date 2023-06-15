import 'package:farma_compara/presentation/core/widgets/format_widgets/text_widget.dart';
import 'package:flutter/material.dart';



class ErrorTextWidget extends StatelessWidget {

  const ErrorTextWidget({
    required this.errorMsg,
    Key? key,
  }) : super(key: key);

  final String errorMsg;

  @override
  Widget build(BuildContext context) {
    return TextWidget(msg: errorMsg, color: Colors.red.shade100);
  }
}
