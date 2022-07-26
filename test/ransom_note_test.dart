// A different, more OOP approach to freq counting is written in the anagram check.
// This kind of mixes different paradigms, but I am just too bored to do everything the simple way.

import 'package:test/test.dart';

/// Given two strings [ransomNote] and [magazine],
/// return true if [ransomNote] can be constructed by using the letters
/// from [magazine] and false otherwise.
///
/// Each letter in [magazine] can only be used once in [ransomNote].
///
/// [ransomNote] and [magazine] consist of lowercase English letters.
bool canConstruct(String ransomNote, String magazine) {
  if (ransomNote.length > magazine.length) return false;
  return _canConstruct(_buildFreqs(ransomNote), _buildFreqs(magazine));
}

bool _canConstruct(List<int> ransomNoteF, List<int> magazineF) {
  for (var i = 0; i < 26; i++) if (ransomNoteF[i] > magazineF[i]) return false;
  return true;
}

extension on String {
  int get charIndex => codeUnitAt(0) - 97;
}

extension on List<int> {
  void incrementAt(int index) => this[index] = this[index] + 1;
}

List<int> _buildFreqs(String s) {
  final list = List.filled(26, 0, growable: false);
  return s.split('').fold(list, (p, e) => p..incrementAt(e.charIndex));
}

void main() {
  group('ransomNote canConstruct', () {
    test('LC examples', () {
      expect(canConstruct('a', 'b'), false);
      expect(canConstruct('aa', 'ab'), false);
      expect(canConstruct('aa', 'aba'), true);
    });

    test('other examples', () {
      expect(canConstruct('a', 'b'), false);
      expect(canConstruct('aa', 'ab'), false);
      expect(canConstruct('aa', 'aba'), true);
    });
  });
}