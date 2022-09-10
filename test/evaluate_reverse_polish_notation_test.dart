import 'dart:collection';

import 'package:test/test.dart';

// https://leetcode.com/problems/evaluate-reverse-polish-notation/discuss/2559166/dart-solution-with-a-stack

/// Evaluate the value of an arithmetic expression in Reverse Polish Notation.
///
/// Valid operators are +, -, *, and /. Each operand may be an integer or another expression.
///
/// Note that division between two integers should truncate toward zero.
///
/// It is guaranteed that the given RPN expression is always valid.
/// That means the expression would always evaluate to a result,
/// and there will not be any division by zero operation.
int evaluateReversePolishNotation(List<String> values) {
  final Queue<int> stack = DoubleLinkedQueue();
  for (final v in values) {
    final op = v.operation;
    stack.push(op == null ? int.parse(v) : op(stack.pop(), stack.pop()));
  }
  return stack.pop();
}

typedef Operation = int Function(int a, int b);

int sum(int a, int b) => b + a;

int subtract(int a, int b) => b - a;

int multiply(int a, int b) => b * a;

int divide(int a, int b) => b ~/ a;

extension on String {
  Operation? get operation =>
      const {'+': sum, '-': subtract, '*': multiply, '/': divide}[this];
}

extension MinimalistStack<E> on Queue<E> {
  void push(E value) => addLast(value);

  E pop() => removeLast();
}

void main() {
  test('leetcode', () {
    expect(13 ~/ 5, 2);
    expect(
      evaluateReversePolishNotation(['2', '1', '+', '3', '*']),
      9,
    );

    expect(
      evaluateReversePolishNotation(['4', '13', '5', '/', '+']),
      6,
    );

    expect(
      evaluateReversePolishNotation(
        [
          '10',
          '6',
          '9',
          '3',
          '+',
          '-11',
          '*',
          '/',
          '*',
          '17',
          '+',
          '5',
          '+',
        ],
      ),
      22,
    );
  });
}
