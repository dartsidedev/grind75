import 'dart:math' as math;

import 'package:test/test.dart';

/// Given an integer array [values], find the contiguous subarray
/// (containing at least one number) which has the largest sum
/// and return its sum.
///
/// A subarray is a contiguous part of an array.
///
/// 1 <= values.length <= 105
/// -104 <= values[i] <= 104
int maximumSubarray(List<int> values) {
  var max = values.first, current = max;
  for (final value in values.skip(1)) {
    /* This is shorter, but more confusing */
    // current = math.max(current + v, v);
    current = current.isNegative ? value : current + value;
    max = math.max(current, max);
  }
  return max;
}

// Time Limit Exceeded on LeetCode
int maximumSubarrayN2(List<int> values) {
  var max = values.first;
  for (var i = 0; i < values.length; i++) {
    for (var j = i, current = 0; j < values.length; j++) {
      current += values[j];
      max = math.max(max, current);
    }
  }
  return max;
}

// Time Limit Exceeded on LeetCode
int maximumSubarrayN3(List<int> values) {
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
