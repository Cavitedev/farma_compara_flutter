import '../core/utils.dart';

class LocationsHierarchy {
  static const locationsHierarchy = {
    "peninsula": {
      "spain": {
        "balearic": {
          "mallorca": "",
          "menorca": "",
          "ibiza": "",
          "formentera": "",
        },
        "canary": "",
        "ceuta_meilla": {
          "ceuta": "",
          "melilla": "",
        },
      },
      "portugal": "",
    },
  };

  static const locationsTranslations = {
    "spain": "España",
    "portugal": "Portugal",
    "balearic": "Baleares",
    "mallorca": "Mallorca",
    "menorca": "Menorca",
    "ibiza": "Ibiza",
    "formentera": "Formentera",
    "canary": "Canarias",
    "ceuta_meilla": "Ceuta y Melilla",
    "ceuta": "Ceuta",
    "melilla": "Melilla",
  };

  static List<String> upperLocationsFrom(String location) {
    final mapKeys = Utils.findParentKeys(locationsHierarchy, location);

    return mapKeys.reversed.toList();
  }
}
