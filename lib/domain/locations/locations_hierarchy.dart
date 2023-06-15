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
        "madrid": "",
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
    "madrid": "Madrid",
  };

  static const specificLocationKeys = [
    "ceuta",
    "melilla",
    "formentera",
    "balearic",
    "canary",
    "madrid",
    "portugal",
    "spain"
  ];

  static final Map<String, String> specificLocations =
      Map.fromEntries(specificLocationKeys.map((e) => MapEntry(e, locationsTranslations[e]!)));

  static List<String> upperLocationsFrom(String location) {
    final mapKeys = Utils.findParentKeys(locationsHierarchy, location);

    return mapKeys.reversed.toList();
  }
}
