import 'package:farma_compara/domain/core/utils.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test("Returns orderer list of items on a map", () {
    Map<String, dynamic> map = {
      'a': {
        'b': {
          'g': 123,
        },
      },
      'd': {
        'e': {
          'f': {
            'c': 456,
          },
        },
      },
    };

    final result = Utils.findParentKeys(map, "c");

    expect(result, ["d", "e", "f"]);
  });
}
