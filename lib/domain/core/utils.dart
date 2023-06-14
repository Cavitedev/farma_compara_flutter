import 'dart:math';

import 'package:farma_compara_flutter/domain/core/i_cloneable.dart';

class Utils {
  static dynamic deepCopy(dynamic item) {
    if (item is Map) {
      var copiedMap = {};
      item.forEach((key, value) {
        copiedMap[key] = deepCopy(value);
      });
      return copiedMap;
    } else if (item is List) {
      var copiedList = [];
      for (var value in item) {
        copiedList.add(deepCopy(value));
      }
      return copiedList;
    } else if (item is ICloneable) {
      return item.clone();
    } else {
      return item;
    }
  }

  ///
  /// Generate a list of unique random numbers in the specified range [min, max)
  ///
  static List<int> generateRandomList(int min, int max, int length) {
    if (length > (max - min)) {
      throw ArgumentError(
          'Cannot generate a list of unique random numbers with the given length in the specified range.');
    }

    Random random = Random();
    Set<int> uniqueSet = Set<int>();

    while (uniqueSet.length < length) {
      int randomNumber = random.nextInt(max - min) + min;
      uniqueSet.add(randomNumber);
    }

    return uniqueSet.toList();
  }

  /// Return a map of the parent keys of the target key
  static List<String> findParentKeys(Map<String, dynamic> map, String targetKey) {
    List<String> parentKeys = [];

    void search(Map<String, dynamic> currentMap, List<String> currentKeys) {
      currentMap.forEach((key, value) {
        if (key == targetKey) {
          parentKeys = currentKeys.toList();
          return;
        }

        if (value is Map<String, dynamic>) {
          List<String> updatedKeys = List.from(currentKeys)..add(key);
          search(value, updatedKeys);
        }
      });
    }

    search(map, []);

    return parentKeys;
  }
}
