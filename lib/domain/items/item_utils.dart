import 'package:flutter/material.dart';

class ItemUtils {
  static const String dosFarma = "dosfarma";
  static const String okFarma = "okfarma";
  static const String farmaciaEnCasa = "farmaciaencasa";
  static const String farmaciasDirect = "farmaciasdirect";

  static List<String> get shopNamesList =>
      [ItemUtils.dosFarma, ItemUtils.okFarma, ItemUtils.farmaciaEnCasa, ItemUtils.farmaciasDirect];

  static String websiteKeyToName(String key) {
    switch (key) {
      case ItemUtils.dosFarma:
        return "DosFarma";
      case ItemUtils.okFarma:
        return "OkFarma";
      case ItemUtils.farmaciaEnCasa:
        return "Farmacia en Casa";
      case ItemUtils.farmaciasDirect:
        return "Farmacias Direct";
    }
    return "Falta soporte para $key";
  }

  static Color websiteKeyToColor(String key) {
    switch (key) {
      case ItemUtils.dosFarma:
        return Colors.green.shade100;
      case ItemUtils.okFarma:
        return Colors.pink.shade100;
      case ItemUtils.farmaciaEnCasa:
        return Colors.yellow.shade100;
      case ItemUtils.farmaciasDirect:
        return Colors.greenAccent.shade100;
    }
    return Colors.blue.shade100;
  }


}
