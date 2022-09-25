import 'dart:math';

import 'package:test/test.dart';

/// Given a binary search tree (BST), find the lowest common ancestor (LCA) node
/// of two given nodes in the BST.
///
/// According to the definition of LCA on Wikipedia:
/// "The lowest common ancestor is defined between two nodes p and q as the
/// lowest node in T that has both p and q as descendants
/// where we allow a node to be a descendant of itself)."
int lowestCommonAncestorIterative1(Node node, int p, int q) {
  var a = min(p, q), b = max(p, q), current = node;
  while (true) {
    final c = current.value;
    if (a == c || b == c || a < c && c < b) return c;
    if (a < c && b < c) current = current.left!;
    if (c < a && c < b) current = current.right!;
  }
}

int lowestCommonAncestorIterative2(Node node, int p, int q) {
  var a = min(p, q), b = max(p, q), current = node;
  while (true) {
    final c = current.value;
    if (a < c && b < c) {
      current = current.left!;
    } else if (c < a && c < b) {
      current = current.right!;
    } else {
      return c;
    }
  }
}

int lowestCommonAncestorRecursive(Node node, int p, int q) {
  var a = min(p, q), b = max(p, q), c = node.value;
  if (a < c && b < c) return lowestCommonAncestorRecursive(node.left!, p, q);
  if (c < a && c < b) return lowestCommonAncestorRecursive(node.right!, p, q);
  return c;
}

class Node {
  Node(this.value, [this.left, this.right]);

  final int value;
  final Node? left;
  final Node? right;
}

void main() {
  test('leetcode examples', () {
    final bst = Node(
      6,
      Node(
        2,
        Node(
          0,
        ),
        Node(
          4,
          Node(3),
          Node(5),
        ),
      ),
      Node(
        8,
        Node(7),
        Node(9),
      ),
    );

    expect(lowestCommonAncestorRecursive(bst, 2, 8), 6);
    expect(lowestCommonAncestorRecursive(bst, 2, 4), 2);
    expect(lowestCommonAncestorRecursive(bst, 7, 9), 8);
    expect(lowestCommonAncestorRecursive(bst, 3, 0), 2);
  });
}


