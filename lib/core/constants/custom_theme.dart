import 'dart:ui';

import 'package:flutter/material.dart';

class CustomTheme{

  static TextStyle? priceText (BuildContext context) {
    return Theme.of(context)
        .textTheme
        .headlineSmall
        ?.copyWith(color: priceColor(context));
  }

  static Color priceColor (BuildContext context) {
    return Theme.of(context).colorScheme.secondary;
  }
}

