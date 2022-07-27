import 'dart:math';

import 'package:test/test.dart';

// Given an integer array [values] sorted in non-decreasing order,
// return an array of the squares of each number sorted in non-decreasing order.
List<int> squared(List<int> values) {
  var length = values.length, left = 0, right = length - 1, i = length - 1;
  final result = List.filled(length, 0, growable: false);
  while (i >= 0) {
    var leftSquared = values[left].squared;
    var rightSquared = values[right].squared;
    result[i--] = max(leftSquared, rightSquared);
    leftSquared > rightSquared ? left++ : right--;
  }
  return result;
}

extension on int {
  int get squared => this * this;
}

void main() {
  group('squares of a sorted array', () {
    test('lc examples', () {
      expect(squared([-4, -1, 0, 3, 10]), [0, 1, 9, 16, 100]);
      expect(squared([-7, -3, 2, 3, 11]), [4, 9, 9, 49, 121]);
    });

    test('my tests', () {
      expect(squared([]), []);
      expect(squared([1, 2, 3]), [1, 4, 9]);
      expect(squared([1, 2, 2, 3]), [1, 4, 4, 9]);
      expect(squared([-2, -1, 1, 2, 3]), [1, 1, 4, 4, 9]);
      expect(squared([-4, -4, -3, -1, 0, 1, 2, 2, 3]),
          [0, 1, 1, 4, 4, 9, 9, 16, 16]);
    });
  });
}
