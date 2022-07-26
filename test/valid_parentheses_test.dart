import 'dart:collection';

import 'package:collection/collection.dart';
import 'package:test/test.dart';

void main() {
  group('isValidParentheses', () {
    test('LC Example 1', () {
      expect(isValidParentheses('()'), true);
    });

    test('LC Example 2', () {
      expect(isValidParentheses('()[]{}'), true);
    });

    test('LC Example 3', () {
      expect(isValidParentheses('(]'), false);
    });

    test('Nested', () {
      expect(isValidParentheses('()[{()(){}[]}]{}'), true);
      expect(isValidParentheses('()[{()(){}[]]}]{}'), false);
    });

    test('Stack empty check', () {
      expect(isValidParentheses('()('), false);
    });

    test('Empty input', () {
      expect(isValidParentheses(''), true);
    });

    test('One char input', () {
      expect(isValidParentheses('('), false);
      expect(isValidParentheses(')'), false);
    });
  });
}

// s consists of parentheses only '()[]{}'.
bool isValidParentheses(String s) {
  final Queue<String> stack = DoubleLinkedQueue();

  for (var i = 0; i < s.length; i++) {
    final parenthesis = s[i];

    if (parenthesis.isOpening) {
      stack.add(parenthesis);
      continue;
    }

    if (stack.isEmpty) return false;
    final lastInStack = stack.pop();
    if (!parenthesis.matches(lastInStack)) return false;
  }

  return stack.isEmpty;
}

extension StringParenthesis on String {
  bool get isOpening => ['(', '[', '{'].contains(this);

  bool matches(String other) {
    if (this == ')') return other == '(';
    if (this == ']') return other == '[';
    if (this == '}') return other == '{';
    throw ArgumentError('Invalid input');
  }
}

extension QueueStack<E> on Queue<E> {
  void push(E value) => addLast(value);

  E pop() => removeLast();

  E? peek() => firstOrNull;
}
