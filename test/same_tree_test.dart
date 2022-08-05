import 'dart:collection';

import 'package:test/test.dart';

bool sameTree(Node? a, Node? b) {
  final stackA = DoubleLinkedQueue<Node?>()..add(a);
  final stackB = DoubleLinkedQueue<Node?>()..add(b);

  while (stackA.isNotEmpty || stackB.isNotEmpty) {
    a = stackA.pop();
    b = stackB.pop();

    if (a == null && b == null) continue;
    if (a == null && b != null || a != null && b == null) return false;
    if (a!.value != b!.value) return false;

    stackA
      ..push(a.left)
      ..push(a.right);
    stackB
      ..push(b.left)
      ..push(b.right);
  }

  return stackA.isEmpty == stackB.isEmpty;
}

extension MinimalistStack<E> on Queue<E> {
  void push(E value) => addLast(value);

  E pop() => removeLast();
}

bool sameTreeRecursive(Node? a, Node? b) {
  if (a == null && b == null) return true;
  if (a != null && b == null || a == null && b != null) return false;
  if (a!.value != b!.value) return false;
  return sameTreeRecursive(a.left, b.left) &&
      sameTreeRecursive(a.right, b.right);
}

// Very simple solution, override the == operator
bool sameTreeOperator(Node a, Node b) => a == b;

class Node {
  const Node(this.value, [this.left, this.right]);

  final int value;
  final Node? left;
  final Node? right;

  @override
  bool operator ==(Object o) =>
      o is Node && o.value == value && o.left == left && o.right == right;

  @override
  int get hashCode => Object.hash(value, left, right);

  @override
  String toString() => '$Node($value, $left, $right)';
}

void main() {
  test('leetcode', () {
    expect(
      Node(1, Node(2), Node(3)) == Node(1, Node(2), Node(3)),
      true,
    );

    expect(
      Node(1, Node(2)) == Node(1, null, Node(2)),
      false,
    );

    expect(
      Node(1, Node(2), Node(1)) == Node(1, Node(1), Node(2)),
      false,
    );
  });

  test('moarrr tests', () {
    expect(
      Node(1, Node(2), Node(3, Node(4))) == Node(1, Node(2), Node(3)),
      false,
    );

    expect(
      Node(1, Node(2)) == Node(1),
      false,
    );

    expect(
      Node(1, Node(2), Node(1)) == Node(1, Node(1), Node(2)),
      false,
    );
  });
}
