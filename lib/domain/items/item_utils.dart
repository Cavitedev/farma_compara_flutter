import 'package:flutter/material.dart';

class ItemUtils {
  static const String dosFarma = "dosfarma";
  static const String dosFarmaName = "DosFarma";
  static const String okFarma = "okfarma";
  static const String okFarmaName = "Okfarma";
  static const String farmaciaEnCasa = "farmaciaencasa";
  static const String farmaciaEnCasaName = "Farmacia en Casa";
  static const String farmaciasDirect = "farmaciasdirect";
  static const String farmaciasDirectName = "Farmacias Direct";

  static List<String> get shopNameKeysList =>
      [ItemUtils.dosFarma, ItemUtils.okFarma, ItemUtils.farmaciaEnCasa, ItemUtils.farmaciasDirect];

  static List<String> get shopNamesList => shopNameKeysList.map((key) => websiteKeyToName(key)).toList();

  static String websiteKeyToName(String key) {
    switch (key) {
      case dosFarma:
        return dosFarmaName;
      case okFarma:
        return okFarmaName;
      case farmaciaEnCasa:
        return farmaciaEnCasaName;
      case farmaciasDirect:
        return farmaciasDirectName;
    }
    if(shopNamesList.contains(key)) {
      return key;
    }

    throw ArgumentError("$key is not a valid website key");
  }

  static String websiteNameToKey(String name) {
    switch (name) {
      case dosFarmaName:
        return dosFarma;
      case okFarmaName:
        return okFarma;
      case farmaciaEnCasaName:
        return farmaciaEnCasa;
      case farmaciasDirectName:
        return farmaciasDirect;
    }

    if(shopNameKeysList.contains(name)) {
      return name;
    }

    throw ArgumentError("$name is not a valid website name");
  }

  static Color websiteKeyToColor(String key) {
    switch (key) {
      case dosFarma:
        return Colors.green.shade100;
      case okFarma:
        return Colors.pink.shade100;
      case farmaciaEnCasa:
        return Colors.yellow.shade100;
      case farmaciasDirect:
        return Colors.greenAccent.shade100;
    }

    return Colors.blue.shade100;
  }
}
