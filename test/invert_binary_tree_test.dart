import 'package:test/test.dart';

// Recursive solution, preorder traversal (postorder would also work).
TreeNode? invertTreeR(TreeNode? node) {
  if (node == null) return null;
  node.swapChildren();
  invertTreeR(node.left);
  invertTreeR(node.right);
  return node;
}

extension on TreeNode {
  void swapChildren() {
    final t = left;
    left = right;
    right = t;
  }
}

class TreeNode {
  TreeNode(this.value, [this.left, this.right]);

  int value;
  TreeNode? left;
  TreeNode? right;

  // Used only for testing
  @override
  bool operator ==(Object o) =>
      o is TreeNode && o.value == value && o.left == left && o.right == right;

  @override
  int get hashCode => Object.hash(value, left, right);
}

void main() {
  test('LC Example 1', () {
    expect(
      invertTreeR(
        TreeNode(
          4,
          TreeNode(2, TreeNode(1), TreeNode(3)),
          TreeNode(7, TreeNode(6), TreeNode(9)),
        ),
      ),
      TreeNode(
        4,
        TreeNode(7, TreeNode(9), TreeNode(6)),
        TreeNode(2, TreeNode(3), TreeNode(1)),
      ),
    );
    expect(
      invertTreeR(TreeNode(2, TreeNode(1), TreeNode(3))),
      TreeNode(2, TreeNode(3), TreeNode(1)),
    );
    expect(invertTreeR(null), null);
  });
}
