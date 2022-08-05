import 'dart:collection';

import 'package:test/test.dart';

// See same_tree_test for other solutions for comparing two trees.

bool subtree(Node a, Node b) {
  final stack = DoubleLinkedQueue<Node>()..add(a);

  while (stack.isNotEmpty) {
    final node = stack.pop();
    if (node == b) return true;
    if (node.left != null) stack.add(node.left!);
    if (node.right != null) stack.add(node.right!);
  }

  return false;
}

extension MiniStack<E> on Queue<E> {
  void push(E value) => addLast(value);

  E pop() => removeLast();
}

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
}

void main() {
  test('leetcode', () {
    expect(
      subtree(
        Node(3, Node(4, Node(1), Node(2)), Node(5)),
        Node(4, Node(1), Node(2)),
      ),
      true,
    );

    expect(
      subtree(
        Node(3, Node(4, Node(1), Node(2, Node(0))), Node(5)),
        Node(4, Node(1), Node(2)),
      ),
      false,
    );
  });
}
