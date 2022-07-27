import 'package:test/test.dart';

int romanToInt(String roman) {
  var value = 0;
  for (var i = 0; i < roman.length; i++) {
    final char = roman[i];
    final nextChar = i == roman.length - 1 ? '' : roman[i + 1];
    final chars = '$char$nextChar';

    final charsValue = _charsMap[chars];
    if (charsValue == null) {
      value += _charMap[char]!;
    } else {
      value += charsValue;
      i++;
    }
  }
  return value;
}

const _charMap = <String, int>{
  'I': 1,
  'V': 5,
  'X': 10,
  'L': 50,
  'C': 100,
  'D': 500,
  'M': 1000,
};

const _charsMap = <String, int>{
  'IV': 4,
  'IX': 9,
  'XL': 40,
  'XC': 90,
  'CD': 400,
  'CM': 900,
};

void main() {
  group('roman', () {
    test('lc examples', () {
      expect(romanToInt('III'), 3);
      expect(romanToInt('LVIII'), 58);
      expect(romanToInt('MCMXCIV'), 1994);
    });
  });
}
