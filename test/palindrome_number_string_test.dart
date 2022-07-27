import 'package:test/test.dart';

bool palindromeNumber(int value) => '$value'.isPalindrome;

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
      expect(palindromeNumber(9292929), true);
      expect(palindromeNumber(1221), true);
      expect(palindromeNumber(141141), true);
      expect(palindromeNumber(141), true);
      expect(palindromeNumber(454), true);
    });
  });
}
