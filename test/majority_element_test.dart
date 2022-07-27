// Given an array [values] of size n, return the majority element.
//
// The majority element is the element that appears more than ⌊n / 2⌋ times.
// You may assume that the majority element always exists in the array.

import 'package:test/test.dart';

int majorityElement(List<int> values) {
  final majorityThreshold = values.length ~/ 2 + 1;

  final counter = <int, int>{};

  for (final v in values) {
    if (counter[v] == null) counter[v] = 0;
    counter[v] = counter[v]! + 1;
    if (counter[v] == majorityThreshold) return v;
  }

  throw ArgumentError('Input violates constraints: no majority element');
}

void main() {
  group('majority element', () {
    test('my examples', () {
      expect(majorityElement([1]), 1);
      expect(majorityElement([2, 1, 1]), 1);
      expect(majorityElement([2, 1, 2, 2]), 2);
      expect(majorityElement([2, 1, 2, 0, 0, 0, 0]), 0);
    });

    test('lc examples', () {
      expect(majorityElement([3, 2, 3]), 3);
      expect(majorityElement([2, 2, 1, 1, 1, 2, 2]), 2);
    });
  });
}
