import 'package:test/test.dart';

// Iterative solution
ListNode? mergeTwoSortedLists(ListNode? list1, ListNode? list2) {
  final prehead = ListNode(0); // value doesn't matter, just to simplify code
  ListNode result = prehead;

  while (list1 != null && list2 != null) {
    if (list1.val < list2.val) {
      result.next = list1;
      list1 = list1.next;
    } else {
      result.next = list2;
      list2 = list2.next;
    }
    result = result.next!;
  }

  list1 ??= list2;
  if (list1 != null) result.next = list1;

  return prehead.next;
}


// Recursive solution.
ListNode? mergeTwoSortedListsR(ListNode? list1, ListNode? list2) {
  if (list1 == null) {
    return list2;
  } else if (list2 == null) {
    return list1;
  } else if (list1.val < list2.val) {
    list1.next = mergeTwoSortedListsR(list1.next, list2);
    return list1;
  } else {
    list2.next = mergeTwoSortedListsR(list2.next, list1);
    return list2;
  }
}

ListNode? mergeTwoSortedListsGolfCode(ListNode? a, ListNode? b) {
  // Do not write code like this, I'm just messing around with operators
  ListNode pre = ListNode(0), r = pre;
  while (a != null && b != null) r = (a < b ? r << (a++) : r << (b++)).next!;
  r << a << b;
  return pre.next;
}

void main() {
  test('mergeTwoSortedLists', () {
    expect(
      mergeTwoSortedLists(
        ListNode(1, ListNode(2, ListNode(4))),
        ListNode(1, ListNode(3, ListNode(4))),
      ),
      ListNode(
          1, ListNode(1, ListNode(2, ListNode(3, ListNode(4, ListNode(4)))))),
    );
    expect(
      mergeTwoSortedLists(null, null),
      null,
    );
    expect(
      mergeTwoSortedLists(null, ListNode(0)),
      ListNode(0),
    );
  });

  test('one input is null', () {
    expect(
      mergeTwoSortedLists(null, ListNode(1, ListNode(3, ListNode(5)))),
      ListNode(1, ListNode(3, ListNode(5))),
    );
  });

  test('duplicate in one list', () {
    expect(
      mergeTwoSortedLists(
        ListNode(1, ListNode(2, ListNode(3))),
        ListNode(4, ListNode(5, ListNode(5))),
      ),
      ListNode(
          1, ListNode(2, ListNode(3, ListNode(4, ListNode(5, ListNode(5)))))),
    );
  });
}

class ListNode {
  ListNode(this.val, [this.next]);

  final int val;
  ListNode? next;

  // For the tests only
  @override
  bool operator ==(Object other) =>
      other is ListNode && other.val == val && other.next == next;

  @override
  int get hashCode => Object.hash(val, next);

  @override
  String toString() => 'Node($val, $next)';
}

extension CodeGolf on ListNode {
  bool operator <(ListNode other) => val < other.val;

  // This goes into code golf territory,
  // but the resulting solution is pretty fun.
  ListNode operator <<(ListNode? other) {
    if (other != null) next = other;
    return this;
  }

  bool operator <=(ListNode other) => val <= other.val;

  bool operator >(ListNode other) => val > other.val;

  bool operator >=(ListNode other) => val >= other.val;

  ListNode? operator +(int i) => next;
}
