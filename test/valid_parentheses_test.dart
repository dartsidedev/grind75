import 'dart:collection';

import 'package:test/test.dart';

bool isValidParentheses(String s) {
  final iter = s.split('');
  final stack = <String>[];
  const opening = ['(', '[', '{'];
  const m = <String, String>{'(': ')', '{': '}', '[': ']'};
  for (var c in iter) {
    if (opening.contains(c)) {
      stack.add(m[c]!);
      continue;
    }
    if (stack.isEmpty) return false;
    if (stack.removeLast() != c) return false;
  }
  return stack.isEmpty;
}

// s consists of parentheses only '()[]{}'.
bool isValidParenthesesFancyDart(String s) {
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

  E? peek() => length == 0 ? null : last;
}

void main() {
  test('leetcode', () {
    expect(isValidParentheses('()'), true);
    expect(isValidParentheses('()[]{}'), true);
    expect(isValidParentheses('(]'), false);
  });

  test('nested', () {
    expect(isValidParentheses('()[{()(){}[]}]{}'), true);
    expect(isValidParentheses('()[{()(){}[]]}]{}'), false);
  });

  test('stack empty check', () {
    expect(isValidParentheses('()('), false);
  });

  test('empty input', () {
    expect(isValidParentheses(''), true);
  });

  test('one char input', () {
    expect(isValidParentheses('('), false);
    expect(isValidParentheses(')'), false);
  });
}
