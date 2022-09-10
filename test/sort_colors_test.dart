import 'package:test/test.dart';

/// Given an array nums with n objects colored red, white, or blue, sort them in-place so that objects of the same color are adjacent, with the colors in the order red, white, and blue.
///
/// We will use the integers 0, 1, and 2 to represent the color red, white, and blue, respectively.
///
/// You must solve this problem without using the library's sort function.
extension on List<int> {
  void sortColors() {
    var c0 = 0, c1 = 0;
    for (final v in this) {
      if (v == 0) c0++;
      if (v == 1) c1++;
    }

    for (var i = 0; i < length; i++)
      this[i] = (c0-- > 0) ? 0 : (c1-- > 0) ? 1 : 2;
  }
}

void main() {
  test('lc', () {
    expect([2, 0, 2, 1, 1, 0]..sortColors(), [0, 0, 1, 1, 2, 2]);
    expect([2, 0, 1]..sortColors(), [0, 1, 2]);
  });
}
