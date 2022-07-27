import 'package:test/test.dart';

bool palindromeNumber(int value) {
  if (value.isNegative) return false;

  var tens = 10;
  while (tens < value) tens *= 10;
  tens = tens ~/ 10;

  while (value > 10) {
    var lastDigit = value % 10;
    var firstDigit = value ~/ tens;

    if (lastDigit != firstDigit) return false;

    value -= firstDigit * tens;
    value = value ~/ 10;
    tens = tens ~/ 100;
  }

  return true;
}

void main() {
  group('palindromeNumber', () {
    test('some examples...', () {
      expect(palindromeNumber(-454), false);
      expect(palindromeNumber(454), true);
      expect(palindromeNumber(0), true);
      expect(palindromeNumber(1), true);
      expect(palindromeNumber(5), true);
      expect(palindromeNumber(9292929), true);
      expect(palindromeNumber(1221), true);
      expect(palindromeNumber(141141), true);
      expect(palindromeNumber(141), true);
      expect(palindromeNumber(454), true);
    });
  });
}
