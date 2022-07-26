import 'package:test/test.dart';

Node? invertTree(Node? node) {
  if (node == null) return null;

  node.swapChildren();

  invertTree(node.left);
  invertTree(node.right);

  return node;
}

class Node {
  Node(this.value, [this.left, this.right]);

  int value;
  Node? left;
  Node? right;

  void swapChildren() {
    final t = left;
    left = right;
    right = t;
  }

  // Used only for testing
  @override
  bool operator ==(Object o) =>
      o is Node && o.value == value && o.left == left && o.right == right;

  @override
  int get hashCode => Object.hash(value, left, right);
}

void main() {
  group('invertTree', () {
    test('LC Example 1', () {
      expect(
        invertTree(
          Node(
            4,
            Node(2, Node(1), Node(3)),
            Node(7, Node(6), Node(9)),
          ),
        ),
        Node(
          4,
          Node(7, Node(9), Node(6)),
          Node(2, Node(3), Node(1)),
        ),
      );
    });

    test('LC Example 2', () {
      expect(
        invertTree(Node(2, Node(1), Node(3))),
        Node(2, Node(3), Node(1)),
      );
    });

    test('LC Example 3', () {
      expect(invertTree(null), null);
    });
  });
}
