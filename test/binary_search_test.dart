import 'package:test/test.dart';

/// Given an array of integers [values] which is sorted in ascending order,
/// and an integer [target], write a function to search target in [values].
/// If [target] exists, then return its index. Otherwise, return -1.
///
/// You must write an algorithm with O(log n) runtime complexity.
///
/// All the integers in [values] are unique.
/// [values] is sorted in ascending order.
int binarySearch(List<int> values, int target) {
  var left = 0, right = values.length - 1;
  while (left <= right) {
    var middle = (left + right) ~/ 2;
    var middleValue = values[middle];
    if (middleValue == target) return middle;
    if (middleValue < target) {
      left = middle + 1;
    } else {
      right = middle;
    }
  }
  return -1;
}

void main() {
  group('binarySearch', () {
    test('LC Example 1', () {
      expect(binarySearch([-1,0,3,5,9,12], 9), 4);
    });

    test('LC Example 2', () {
      expect(binarySearch( [-1,0,3,5,9,12], 2), -1);
    });

    test('examples not found', () {
      expect(binarySearch([], 9), -1);
      expect(binarySearch([1, 2, 3, 4], 0), -1);
      expect(binarySearch([1, 2, 3, 4], 5), -1);
      expect(binarySearch([1, 2, 4], 3), -1);
    });

    test('examples found', () {
      expect(binarySearch([1], 1), 0);
      expect(binarySearch([1, 2], 1), 0);
      expect(binarySearch([1, 2], 2), 1);
      expect(binarySearch([1, 2, 3, 4], 2), 1);
      expect(binarySearch([1, 2, 3, 4], 4), 3);
      expect(binarySearch([1, 2, 4, 100, 101], 100), 3);
    });
  });
}
