import 'package:test/test.dart';

/// A phrase is a palindrome if, after converting all uppercase letters into
/// lowercase letters and removing all non-alphanumeric characters,
/// it reads the same forward and backward.
/// Alphanumeric characters include letters and numbers.
///
/// Given a string s, return true if it is a palindrome, or false otherwise.
bool isPalindrome(String s) {
  var i = 0, j = s.length - 1;

  while (i < j) {
    while (i < j && !s[i].isAlphaNumeric) i++;
    while (i < j && !s[j].isAlphaNumeric) j--;
    if (s[i++].lower != s[j--].lower) return false;
  }

  return true;
}

bool isPalindrome2(String s) {
  final filtered =
      s.split('').where((c) => c.isAlphaNumeric).map((c) => c.lower).join('');
  return filtered == filtered.split('').reversed.join('');
}

extension StringIsAlphaNumeric on String {
  bool get isAlphaNumeric {
    final codeUnit = codeUnitAt(0);
    final isNumber = 48 <= codeUnit && codeUnit <= 57;
    final isUpperCase = 65 <= codeUnit && codeUnit <= 90;
    final isLowerCase = 97 <= codeUnit && codeUnit <= 122;
    return isNumber || isLowerCase || isUpperCase;

    // Or with regexp:
    // return RegExp(r'^[a-zA-Z0-9]$').hasMatch(this);

    // this wouldn't work due to _: return RegExp(r'^[\w\d]$').hasMatch(this);
  }

  String get lower => toLowerCase();
}

void main() {
  test('palindrome', () {
    expect(isPalindrome('A man, a plan, a canal: Panama'), true);
    expect(isPalindrome('race a car'), false);
    expect(isPalindrome(''), true);
    expect(isPalindrome('.,'), true);
  });
}
