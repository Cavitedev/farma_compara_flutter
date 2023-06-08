import 'package:farma_compara_flutter/presentation/core/widgets/text_widget.dart';
import 'package:farma_compara_flutter/presentation/core/widgets/text_with_image.dart';
import 'package:flutter/material.dart';


class InfoTextWithImage extends StatelessWidget {
  const InfoTextWithImage({
    Key? key,
    required this.msg,
    required this.image,
  }) : super(key: key);

  final String msg;
  final String image;

  @override
  Widget build(BuildContext context) {
    return TextWithImage(
      textWidget: TextWidget(msg: msg, color: Colors.blue.shade100),
      image: image,
    );
  }
}
