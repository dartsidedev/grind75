import 'package:test/test.dart';

int middleOfTheLinkedList(Node head) {
  var length = 0;
  Node? node = head;
  while (node != null) {
    length++;
    node = node.next;
  }
  node = head;
  final middleIndex = length ~/ 2;

  var i = 0;
  while (i < middleIndex) {
    node = node?.next;
    i++;
  }

  return node!.value;
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
