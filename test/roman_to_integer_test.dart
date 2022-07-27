/*
Roman numerals are represented by seven different symbols: I, V, X, L, C, D and M.

Symbol       Value
I             1
V             5
X             10
L             50
C             100
D             500
M             1000

For example, 2 is written as II in Roman numeral, just two ones added together.
12 is written as XII, which is simply X + II. The number 27 is written as XXVII,
which is XX + V + II.

Roman numerals are usually written largest to smallest from left to right.
However, the numeral for four is not IIII.
Instead, the number four is written as IV.
Because the one is before the five we subtract it making four.
The same principle applies to the number nine, which is written as IX.
There are six instances where subtraction is used:

I can be placed before V (5) and X (10) to make 4 and 9.
X can be placed before L (50) and C (100) to make 40 and 90.
C can be placed before D (500) and M (1000) to make 400 and 900.
Given a roman numeral, convert it to an integer.

IV IX
XL XC
CD CM

 */

import 'package:test/test.dart';

int romanToInt(String roman) {
  var value = 0;
  for (var i = 0; i < roman.length; i++) {
    final char = roman[i];
    final nextChar = i == roman.length - 1 ? '' : roman[i + 1];
    final chars = '$char$nextChar';

    switch (chars) {
      case 'IV':
        value += 4;
        i++;
        continue;
      case 'IX':
        value += 9;
        i++;
        continue;
      case 'XL':
        value += 40;
        i++;
        continue;
      case 'XC':
        value += 90;
        i++;
        continue;
      case 'CD':
        value += 400;
        i++;
        continue;
      case 'CM':
        value += 900;
        i++;
        continue;
    }

    switch (char) {
      case 'I':
        value += 1;
        break;
      case 'V':
        value += 5;
        break;
      case 'X':
        value += 10;
        break;
      case 'L':
        value += 50;
        break;
      case 'C':
        value += 100;
        break;
      case 'D':
        value += 500;
        break;
      case 'M':
        value += 1000;
        break;
    }
  }
  return value;
}

void main() {
  group('roman', () {
    test('lc examples', () {
      expect(romanToInt('III'), 3);
      expect(romanToInt('LVIII'), 58);
      expect(romanToInt('MCMXCIV'), 1994);
    });
  });
}
