import 'package:test/test.dart';

bool hasCycle(Node head) {
  Node? slow = head, fast = head;
  while (true) {
    slow = slow!.next;
    fast = fast!.next?.next;
    if (fast == null) return false;
    if (fast == slow) return true;
  }
}

class Node {
  Node(this.value, [this.next]);

  int value;
  Node? next;
}

void main() {
  group('hasCycle', () {
    test('my examples', () {
      expect(hasCycle(Node(4)), false);
      expect(hasCycle(Node(3, Node(2, Node(1)))), false);
      expect(hasCycle(Node(3, Node(2, Node(1, Node(0))))), false);

      late Node n;
      late Node cyclic;

      n = Node(0);
      cyclic = Node(3, Node(2, Node(1, n)));
      n.next = cyclic;
      expect(hasCycle(cyclic), true);

      n = Node(0);
      cyclic = Node(3, Node(2, Node(1, n)));
      n.next = cyclic.next;
      expect(hasCycle(cyclic), true);

      n = Node(0);
      cyclic = Node(3, Node(2, Node(1, n)));
      n.next = cyclic.next!.next;
      expect(hasCycle(cyclic), true);

      n = Node(0);
      cyclic = Node(3, Node(2, Node(1, n)));
      n.next = cyclic.next!.next!.next;
      expect(hasCycle(cyclic), true);
    });
  });
}
