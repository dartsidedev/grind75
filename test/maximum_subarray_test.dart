import 'dart:math' as math;

import 'package:test/test.dart';

/****** See all solutions at the bottom of the file ******/

/// Given an integer array [values], find the contiguous subarray
/// (containing at least one number) which has the largest sum
/// and return its sum.
///
/// A subarray is a contiguous part of an array.
///
/// Constraints:
///
/// 1 <= nums.length <= 105
/// -104 <= nums[i] <= 104
///
///
/// Follow up: If you have figured out the O(n) solution, try coding another
/// solution using the divide and conquer approach, which is more subtle.
int maximumSubarray(List<int> values) {
  var max = values.first, current = max;
  for (final v in values.skip(1)) {
    current = math.max(current + v, v);
    max = math.max(current, max);
  }
  return max;
}

void main() {
  group('maximumSubarray', () {
    test('lc examples', () {
      expect(maximumSubarray([-2, 1, -3, 4, -1, 2, 1, -5, 4]), 6);
      expect(maximumSubarray([1]), 1);
      expect(maximumSubarray([5, 4, -1, 7, 8]), 23);
    });

    test('more examples', () {
      expect(maximumSubarray([-1]), -1);
      expect(maximumSubarray([0]), 0);
      expect(maximumSubarray([2, -1, 2]), 3);
      expect(maximumSubarray([-1, 4, -1]), 4);
      expect(maximumSubarray([5, 4, -1, -99, 7, 8]), 15);
      expect(maximumSubarray([-5, -4, -3, -6, -9, -2, -7]), -2);
      expect(maximumSubarray([-1, -4, -3, -6, -9, -2, -7]), -1);
      expect(maximumSubarray([-1, -4, -3, -6, -9, -2, 0]), 0);
    });
  });
}

// Other solutions:

int maximumSubarrayN2(List<int> values) {
  // n^2
  var max = values.first;
  for (var i = 0; i < values.length; i++) {
    var current = 0;
    for (var j = i; j < values.length; j++) {
      current += values[j];
      max = math.max(max, current);
    }
  }
  return max;
}

int maximumSubarrayN3(List<int> values) {
  // n^3
  var max = values.first;
  for (var i = 0; i < values.length; i++) {
    for (var j = i; j < values.length; j++) {
      var current = 0;
      for (var k = i; k <= j; k++) current += values[k];
      max = math.max(max, current);
    }
  }
  return max;
}
