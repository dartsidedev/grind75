import 'package:test/test.dart';

int middleOfTheLinkedList(Node head) {
  Node? slow = head, fast = head;

  while (fast != null && fast.next != null) {
    slow = slow?.next;
    fast = fast.next!.next;
  }

  return slow!.value;
}

class Node {
  Node(this.value, [this.next]);

  final int value;
  final Node? next;
}

void main() {
  group('middle of the linked list', () {
    test('lc examples', () {
      expect(
        middleOfTheLinkedList(Node(1, Node(2, Node(3, Node(4, Node(5)))))),
        3,
      );

      expect(
        middleOfTheLinkedList(
            Node(1, Node(2, Node(3, Node(4, Node(5, Node(6))))))),
        4,
      );
    });
  });
}
