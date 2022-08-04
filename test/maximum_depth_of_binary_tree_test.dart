import 'dart:collection';
import 'dart:math' as math;

import 'package:test/test.dart';

int maxDepth(Node? root) {
  if (root == null) return 0;

  var q = DoubleLinkedQueue<Node>()..add(root), d = 0;

  // BFS
  while (q.isNotEmpty) {
    var i = 0, length = q.length;
    while (i < length) {
      var node = q.dequeue();
      if (node.left != null) q.enqueue(node.left!);
      if (node.right != null) q.enqueue(node.right!);
      i++;
    }
    d++;
  }

  return d;
}

extension MinimalistQueue<T> on Queue<T> {
  void enqueue(T value) => addLast(value);

  T dequeue() => removeFirst();
}

// recursive solution
int maxDepthRec(Node? node) {
  if (node == null) return 0;
  return math.max(
        maxDepthRec(node.left),
        maxDepthRec(node.right),
      ) +
      1;
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
  test('leetcode examples', () {
    expect(
      maxDepth(Node(3, Node(9), Node(20, Node(15), Node(7)))),
      3,
    );
  });

  test('my examples', () {
    expect(
      maxDepth(null),
      0,
    );

    expect(
      maxDepth(Node(4)),
      1,
    );

    expect(
      maxDepth(Node(4, Node(2))),
      2,
    );
  });
}
