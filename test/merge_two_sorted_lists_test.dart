import 'package:test/test.dart';

Node? mergeTwoSortedLists(Node? l1, Node? l2) {
  final prehead = Node(0); // value doesn't matter, just to simplify code
  Node result = prehead;

  while (l1 != null && l2 != null) {
    if (l1 < l2) {
      result.next = l1;
      l1 = l1.next;
    } else {
      result.next = l2;
      l2 = l2.next;
    }
    result = result.next!;
  }

  l1 ??= l2;
  if (l1 != null) result.next = l1;

  return prehead.next;
}

void main() {
  group('mergeTwoSortedLists', () {
    test('LC Example 1', () {
      expect(
        mergeTwoSortedLists(
          Node(1, Node(2, Node(4))),
          Node(1, Node(3, Node(4))),
        ),
        Node(1, Node(1, Node(2, Node(3, Node(4, Node(4)))))),
      );
    });

    test('LC Example 2', () {
      expect(
        mergeTwoSortedLists(null, null),
        null,
      );
    });

    test('LC Example 3', () {
      expect(
        mergeTwoSortedLists(null, Node(0)),
        Node(0),
      );
    });

    test('Example 3', () {
      expect(
        mergeTwoSortedLists(null, Node(1, Node(3, Node(5)))),
        Node(1, Node(3, Node(5))),
      );
    });

    test('Example 2', () {
      expect(
        mergeTwoSortedLists(
          Node(1, Node(2, Node(3))),
          Node(4, Node(5, Node(5))),
        ),
        Node(1, Node(2, Node(3, Node(4, Node(5, Node(5)))))),
      );
    });
  });
}

class Node {
  Node(this.value, [this.next]);

  final int value;
  Node? next;

  // For the tests only
  @override
  bool operator ==(Object other) =>
      other is Node && other.value == value && other.next == next;

  @override
  int get hashCode => Object.hash(value, next);

  @override
  String toString() => 'Node($value, $next)';

  bool operator <(Node other) => value < other.value;
  bool operator <=(Node other) => value <= other.value;
  bool operator >(Node other) => value > other.value;
  bool operator >=(Node other) => value >= other.value;

  // This goes into code golf territory, but the resulting solution is pretty neat.
  // Node? operator +(int i) => next;
}
