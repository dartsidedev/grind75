import 'package:test/test.dart';

/// Given a string [input] which consists of lowercase or uppercase letters,
/// return the length of the longest palindrome
/// that can be built with those letters.
///
/// Letters are case sensitive, for example,
/// "Aa" is not considered a palindrome here.
int longestPalindrome(String input) {
  final counter = List.filled(52, 0, growable: false);
  for (final s in input.split('')) counter[s.index] = counter[s.index] + 1;

  var longest = 0, oneLeft = counter.any((c) => c.isOdd);
  for (var c in counter) longest += (c ~/ 2) * 2;
  /* or: */ // longest = counter.fold<int>(0, (p, c) => p + (c ~/ 2) * 2);
  return longest + (oneLeft ? 1 : 0);
}

extension on String {
  int get index {
    final codeUnit = codeUnitAt(0);
    if (65 <= codeUnit && codeUnit <= 90) return codeUnit - 65;
    return codeUnit - 97 + 26;
  }
}

void main() {
  group('longestPalindrome', () {
    test('lc examples', () {
      expect(longestPalindrome('abccccdd'), 7);
      expect(longestPalindrome('a'), 1);
    });

    test('more examples', () {
      expect(longestPalindrome('aabbcc'), 6);
      expect(longestPalindrome('aabbccd'), 7);
      expect(longestPalindrome('aabbccdD'), 7);
      expect(longestPalindrome('AAaabbccdD'), 9);
      expect(longestPalindrome('Aabbcc'), 5);
      expect(longestPalindrome('Aabbccc'), 5);
    });
  });

  test('charIndex', () {
    expect('A'.index, 0);
    expect('B'.index, 1);
    expect('Z'.index, 25);
    expect('a'.index, 26);
    expect('b'.index, 27);
    expect('z'.index, 51);
  });
}
