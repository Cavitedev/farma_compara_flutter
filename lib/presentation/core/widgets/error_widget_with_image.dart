import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import '../../../core/constants/app_margin_and_sizes.dart';
import 'error_text_widget.dart';

class ErrorWidgetWithImage extends StatelessWidget {
  const ErrorWidgetWithImage({
    Key? key,
    required this.msg,
    required this.image,
  }) : super(key: key);

  final String msg;
  final String image;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: listPadding),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const SizedBox(
            height: listSpacing,
          ),
          ErrorTextWidget(
            errorMsg: msg,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: listSpacing),
            child: SvgPicture.asset(
              image,
              height: 300,
              alignment: Alignment.topCenter,
            ),
          ),
        ],
      ),
    );
  }
}
