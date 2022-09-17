import 'package:collection/collection.dart';
import 'package:test/test.dart';

/// Given two strings [s1] and [s2],
/// return true if [s2] is an anagram of [s1],
/// and false otherwise.
///
/// An Anagram is a word or phrase formed by rearranging the letters of a
/// different word or phrase, typically using all the original letters
/// exactly once.
///
/// [s1] and [s2] consist of lowercase English letters.
bool validAnagram(String s1, String s2) {
  return s1.length == s2.length && Counter(s1) == Counter(s2);
}

class Counter {
  Counter(String string) : _values = _valuesFromString(string);

  final List<int> _values;

  static List<int> _valuesFromString(String s) {
    final values = List.filled(26, 0, growable: false);
    for (var i = 0; i < s.length; i++) values[s[i].charIndex]++;
    return values;
  }

  @override
  bool operator ==(Object? o) =>
      o is Counter && const ListEquality().equals(_values, o._values);

  @override
  int get hashCode => _values.hashCode;
}

extension CharToIndex on String {
  int get charIndex => codeUnitAt(0) - 97;
}

void main() {
  test('leetcode', () {
    expect(validAnagram('anagram', 'nagaram'), true);
    expect(validAnagram('rat', 'car'), false);
  });

  test('more examples', () {
    expect(validAnagram('aaab', 'abba'), false);
    expect(validAnagram('aaabb', 'ababa'), true);
    expect(validAnagram('aaab', 'abba'), false);
    expect(validAnagram('', ''), true);
    expect(validAnagram('a', 'b'), false);
    expect(validAnagram('a', 'a'), true);
  });
}
