import 'package:test/test.dart';

bool palindromeNumber(int value) {
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
