import 'dart:collection';
import 'dart:math' as math;

import 'package:test/test.dart';

int diameter(Node root) {
  final stack1 = DoubleLinkedQueue<Node>()..add(root);
  final stack2 = DoubleLinkedQueue<Node>();

  var node = root;
  while (stack1.isNotEmpty) {
    node = stack1.pop();
    if (node.left != null) stack1.push(node.left!);
    if (node.right != null) stack1.push(node.right!);
    stack2.push(node);
  }

  var maxDiameter = 0;
  final heights = <Node, int>{};

  int getHeight(Node? node) => node == null ? 0 : heights[node] ?? 1;

  while (stack2.isNotEmpty) {
    node = stack2.pop();
    var leftHeight = getHeight(node.left);
    var rightHeight = getHeight(node.right);
    maxDiameter = math.max(leftHeight + rightHeight, maxDiameter);
    heights[node] = math.max(leftHeight, rightHeight) + 1;
  }

  return maxDiameter;
}

extension MinimalistStack<E> on Queue<E> {
  void push(E value) => addLast(value);

  E pop() => removeLast();
}

int diameterRecursive(Node root) {
  var maxDiameter = 0;

  int height(Node? node) {
    if (node == null) return 0;
    var leftHeight = height(node.left);
    var rightHeight = height(node.right);
    maxDiameter = math.max(leftHeight + rightHeight, maxDiameter);
    return math.max(leftHeight, rightHeight) + 1;
  }

  height(root);
  return maxDiameter;
}

class Node {
  const Node(this.value, [this.left, this.right]);

  final int value;

  final Node? left;
  final Node? right;

  @override
  String toString() => '$Node($value, $left, $right)';
}

void main() {
  test('leetcode', () {
    expect(diameter(Node(1, Node(2, Node(4), Node(5)), Node(3))), 3);
    expect(diameter(Node(1, Node(2))), 1);
  });
}
