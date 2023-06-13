class Utils{
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