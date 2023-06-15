import 'package:farma_compara/presentation/core/widgets/format_widgets/text_with_image.dart';
import 'package:flutter/material.dart';
import 'error_text_widget.dart';

class ErrorTextWithImage extends StatelessWidget {
  const ErrorTextWithImage({
    Key? key,
    required this.msg,
    required this.image,
  }) : super(key: key);

  final String msg;
  final String image;

  @override
  Widget build(BuildContext context) {
    return TextWithImage(
      textWidget: ErrorTextWidget(
        errorMsg: msg,
      ),
      image: image,
    );
  }
}
