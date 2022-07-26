import 'package:test/test.dart';

/// Given an array of integers [numbers] and an integer [target],
/// returns the indices of the two numbers such that they add up to [target].
List<int> twoSum(List<int> numbers, int target) {
  // The key is the number, the value is the index of this number in the
  // original [numbers] list.
  final map = <int, int>{};

  for (var i = 0; i < numbers.length; i++) {
    final number = numbers[i];
    final complementIndex = map[target - number];

    if (complementIndex != null) return [complementIndex, i];

    map[number] = i;
  }

  throw ArgumentError('Input violates assumption: exactly one solution');
}


void main() {
  group('twoSum', () {
    test('LC Example 1', () {
      expect(twoSum([2, 7, 11, 15], 9), [0, 1]);
    });

    test('LC Example 2', () {
      expect(twoSum([3, 2, 4], 6), [1, 2]);
    });

    test('LC Example 3', () {
      expect(twoSum([3, 3], 6), [0, 1]);
    });
  });
}

