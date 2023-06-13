import '../core/utils.dart';

class LocationsHierarchy{
  static var locationsHierarchy = {
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

  static List<String> upperLocationsFrom(String location){
    final mapKeys = Utils.findParentKeys(locationsHierarchy, location);

    return mapKeys.reversed.toList();

  }



}