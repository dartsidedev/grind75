import 'package:test/test.dart';

Node reverse(Node head) {
  final preHead = Node(0);

  Node? i = head;
  while (i != null) {
    final moved = i;
    i = i.next;
    moved.next = preHead.next;
    preHead.next = moved;
  }

  return preHead.next!;
}

class Node {
  Node(this.value, [this.next]);

  int value;
  Node? next;

  @override
  String toString() => 'Node($value, $next)';

  @override
  bool operator ==(Object o) => o is Node && o.value == value && o.next == next;

  @override
  int get hashCode => Object.hash(value, next);
}

void main() {
  group('reverse linked list', () {
    test('one node', () {
      expect(reverse(Node(5)), Node(5));
    });

    test('two nodes', () {
      expect(reverse(Node(5, Node(4))), Node(4, Node(5)));
    });

    test('nodes', () {
      expect(
        reverse(Node(5, Node(4, Node(3, Node(2, Node(1)))))),
        Node(1, Node(2, Node(3, Node(4, Node(5))))),
      );
    });
  });
}
