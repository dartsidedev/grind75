import 'package:test/test.dart';

bool isValidPalindrome(String source) {
  int i = 0, j = source.length - 1;

  while (i < j) {
    while (!source[i].isAlphaNumericChar) i++;
    while (!source[j].isAlphaNumericChar) j--;
    if (!source[i++].caseInsensitiveEquals(source[j--])) return false;
  }

  return true;
}

extension StringIsAlphaNumeric on String {
  bool get isAlphaNumericChar {
    // Or with regexp:
    // return RegExp(r'^[\w\d]$').hasMatch(this);
    final codeUnit = codeUnitAt(0);
    final isNumber = 48 <= codeUnit && codeUnit <= 57;
    final isUpperCase = 65 <= codeUnit && codeUnit <= 90;
    final isLowerCase = 97 <= codeUnit && codeUnit <= 122;
    return isNumber || isLowerCase || isUpperCase;
  }

  bool caseInsensitiveEquals(String o) => toLowerCase() == o.toLowerCase();
}

void main() {
  group('isValidPalindrome', () {
    test('LC Example 1', () {
      expect(isValidPalindrome('A man, a plan, a canal: Panama'), true);
    });

    test('LC Example 2', () {
      expect(isValidPalindrome('race a car'), false);
    });

    test('LC Example 3', () {
      expect(isValidPalindrome(''), true);
    });
  });
}
