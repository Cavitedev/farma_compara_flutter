import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import '../../../../core/constants/app_margin_and_sizes.dart';


class TextWithImage extends StatelessWidget {
  const TextWithImage({
    Key? key,
    required this.textWidget,
    required this.image,
  }) : super(key: key);

  final Widget textWidget;
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
          textWidget,
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
