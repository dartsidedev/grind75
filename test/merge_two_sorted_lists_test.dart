import 'package:test/test.dart';

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

  // This goes into code golf territory, but the resulting solution is pretty neat.
  // bool operator <(Node other) => value < other.value;
  // Node? operator +(int i) => next;
}

Node? mergeTwoSortedLists(Node? l1, Node? l2) {
  final prehead = Node(0); // value doesn't matter
  Node iterResult = prehead;

  Node? iter1 = l1;
  Node? iter2 = l2;

  while (iter1 != null && iter2 != null) {
    if (iter1.value < iter2.value) {
      iterResult.next = iter1;
      iter1 = iter1.next;
    } else {
      iterResult.next = iter2;
      iter2 = iter2.next;
    }
    iterResult = iterResult.next!;
  }

  iter1 ??= iter2;
  if (iter1 != null) iterResult.next = iter1;

  return prehead.next;
}
