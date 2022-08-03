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

bool palindromeNumberList(int value) {
  if (value.isNegative) return false;

  final list = _convert(value);
  for (int i = 0; i < (list.length ~/ 2); i++) {
    if (list[i] != list[list.length - 1 - i]) return false;
  }

  return true;
}

List<int> _convert(int value) {
  final list = <int>[];
  while (value > 0) {
    list.add(value % 10);
    value = value ~/ 10;
  }
  return list;
}

bool palindromeNumberReverted(int value) {
  if (value.isNegative) return false;
  if (value == 0) return true;
  if (value % 10 == 0) return false;

  var reverted = 0, iter = value;
  while (iter > 0) {
    reverted = reverted * 10;
    reverted += iter % 10;
    iter = iter ~/ 10;
  }

  return reverted == value;
}

bool palindromeNumberStrings(int value) => '$value'.isPalindrome;

extension on String {
  // There are obviously better ways to code this, but hey, I already did
  // something similar for a different challenge: valid_palindrome_test.
  bool get isPalindrome => this == split('').reversed.join('');
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
