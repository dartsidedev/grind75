import 'package:test/test.dart';

bool palindromeNumber(int value) {
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

void main() {
  group('palindromeNumber', () {
    test('some examples...', () {
      expect(palindromeNumber(-454), false);
      expect(palindromeNumber(454), true);
      expect(palindromeNumber(0), true);
      expect(palindromeNumber(9292929), true);
      expect(palindromeNumber(1221), true);
      expect(palindromeNumber(141141), true);
      expect(palindromeNumber(141), true);
      expect(palindromeNumber(454), true);
    });
  });
}
