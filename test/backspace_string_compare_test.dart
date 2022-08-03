import 'dart:collection';
import 'package:test/test.dart';

bool backspaceStringCompare(String a, String b) {
  Iterable<String> reverse(String input) sync* {
    var backspaces = 0;
    for (var i = input.length - 1; i >= 0; i--) {
      final ch = input[i];
      if (ch == '#') {
        backspaces++;
        continue;
      }
      if (backspaces > 0) {
        backspaces--;
        continue;
      }
      yield ch;
    }
  }

  var aIter = reverse(a).iterator, bIter = reverse(b).iterator;
  while (true) {
    var aNext = aIter.moveNext();
    var bNext = bIter.moveNext();
    if (aNext != bNext) return false;
    if (!aNext && !bNext) return true;
    if (aIter.current != bIter.current) return false;
  }
}

bool backspaceStringCompareStacks(String a, String b) {
  Queue stack(String input) {
    final result = DoubleLinkedQueue<String>();
    for (var i = 0; i < input.length; i++) {
      final ch = input[i];
      if (ch == '#') {
        result.popMaybe();
      } else {
        result.push(ch);
      }
    }
    return result;
  }

  bool compare(Queue a, Queue b) {
    if (a.length != b.length) return false;
    while (a.isNotEmpty) if (a.pop() != b.pop()) return false;
    return true;
  }

  return compare(stack(a), stack(b));
}

extension StackQueue<T> on Queue<T> {
  void push(T value) => addLast(value);

  T pop() => removeLast();

  T? popMaybe() => this.isEmpty ? null : removeLast();
}

void main() {
  test('lc', () {
    expect(backspaceStringCompare('ab#c', 'ad#c'), true);
    expect(backspaceStringCompare('ab##', 'c#d#'), true);
    expect(backspaceStringCompare('a#c', 'b'), false);
  });

  test('my examples', () {
    expect(backspaceStringCompare('ab#cd', 'ad#cde#'), true);
    expect(backspaceStringCompare('abc##', 'a'), true);
    expect(backspaceStringCompare('a', 'b'), false);
  });
}
