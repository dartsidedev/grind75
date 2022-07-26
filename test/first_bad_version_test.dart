import 'package:test/test.dart';

// Note: I used 0-based, and I also got rid of the "isBad" API call.

/// Suppose you have n versions [0, 1, 2, ..., n] and
/// you want to find out the first bad one,
/// which causes all the following ones to be bad.
///
/// [versions]'s element true means successful, correct version.
/// [versions]'s element false means bad version.
///
/// Solution assumes there is at least one bad version.
int firstBadVersion(List<bool> versions) {
  var left = 0, right = versions.length - 1, middle = -1, middleValue = false;
  while (left < right) {
    middle = (left + right) ~/ 2;
    middleValue = versions[middle];
    if (middleValue)  left = middle + 1;
    if (!middleValue) right = middle;
  }
  return right;
}

void main() {
  group('firstBadVersion', () {
    test('LC Example 1', () {
      expect(firstBadVersion([true, true, true, true, false, false]), 4);
    });

    test('LC Example 2', () {
      expect(firstBadVersion([false]), 0);
    });

    test('MOAAAARRR EXAMPLESS!', () {
      expect(firstBadVersion([false, false]), 0);
      expect(firstBadVersion([false, false, false]), 0);

      expect(firstBadVersion([true, false]), 1);
      expect(firstBadVersion([true, false, false]), 1);
      expect(firstBadVersion([true, false, false, false]), 1);
      expect(firstBadVersion([true, false, false, false, false]), 1);

      expect(firstBadVersion([true, true, false]), 2);
      expect(firstBadVersion([true, true, false, false]), 2);
      expect(firstBadVersion([true, true, false, false, false]), 2);
      expect(firstBadVersion([true, true, false, false, false, false]), 2);

      expect(firstBadVersion([true, true, false]), 2);
      expect(firstBadVersion([true, true, true, false]), 3);
      expect(firstBadVersion([true, true, true, true, false]), 4);
      expect(firstBadVersion([true, true, true, true, false, false]), 4);
      expect(firstBadVersion([true, true, true, true, true, false]), 5);

    });
  });
}