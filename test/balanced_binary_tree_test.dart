import 'dart:math';

import 'package:test/test.dart';

bool isBalanced(Node root) => _height(root) != -1;

int _height(Node? node) {
  print(node?.value);
  if (node == null) return 0;
  return _merge(
    _height(node.left),
    _height(node.right),
  );
}

int _merge(int a, int b) {
  if (a == -1 || b == -1) return -1;
  final diff = max(a - b, b - a);
  if (diff > 1) return -1;
  return max(a, b) + 1;
}

class Node {
  Node(this.value, [this.left, this.right]);

  final int value;
  final Node? left;
  final Node? right;

  @override
  String toString() => '$Node($value, $left, $right)';
}

void main() {
  test('leetcode examples', () {
    expect(
      isBalanced(Node(3, Node(9), Node(20, Node(15), Node(7)))),
      true,
    );

    expect(
      isBalanced(Node(1, Node(2, Node(3, Node(4), Node(5)), Node(6)), Node(7))),
      false,
    );
  });

  test('examples', () {
    expect(
      isBalanced(Node(1)),
      true,
    );

    expect(
      isBalanced(Node(1, Node(2), Node(3))),
      true,
    );

    expect(
      isBalanced(Node(1, Node(2))),
      true,
    );

    expect(
      isBalanced(Node(1, null, Node(3))),
      true,
    );

    expect(
      isBalanced(Node(1, Node(2, Node(3), Node(3)), Node(2))),
      true,
    );

    expect(
      isBalanced(Node(1, Node(2, Node(3)))),
      false,
    );

    expect(
      isBalanced(Node(1, Node(2, Node(3, Node(4, Node(5)))))),
      false,
    );
  });
}

bool isBalancedAlternative(Node root) => _info(root).isBalanced;

NodeInfo _info(Node? node) {
  if (node == null) return NodeInfo.none();
  return NodeInfo.merge(_info(node.left), _info(node.right));
}

class NodeInfo {
  const NodeInfo(this.height, this.isBalanced);

  static merge(NodeInfo a, NodeInfo b) {
    final diff = max(a.height - b.height, b.height - a.height);
    return NodeInfo(
      max(a.height, b.height) + 1,
      a.isBalanced && b.isBalanced && diff <= 1,
    );
  }

  const NodeInfo.none()
      : height = 0,
        isBalanced = true;

  final int height;
  final bool isBalanced;
}
