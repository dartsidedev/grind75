import 'dart:math' as math;

import 'package:test/test.dart';

int reverseBits(int value) {
  if (value <= 0 || math.pow(2, 32) <= value) throw 'Expected 32-bit int';

  int result = 0, i = 0;
  while (i < 32) {
    result <<= 1; // shift result left
    result += value & 1; // get rightmost bit of the value, add to result
    value >>= 1; // shift value right
    i++;
  }
  return result;
}

void main() {
  test('leetcode', () {
    expect(reverseBits(43261596), 964176192);
    expect(reverseBits(4294967293), 3221225471);
  });

  test('some other tests', () {
    expect(reverseBits(964176192), 43261596);
    expect(reverseBits(3221225471), 4294967293);
    expect(() => reverseBits(math.pow(2, 32).toInt()), throwsArgumentError);
    expect(() => reverseBits(math.pow(2, 32).toInt() + 1), throwsArgumentError);
  });
}
