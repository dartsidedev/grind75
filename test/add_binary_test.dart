import 'dart:math';

import 'package:test/test.dart';

String add(String a, String b) {
  final r = <int>[];

  var carry = 0;
  for (var i = 0; i < max(a.length, b.length); i++) {
    var sum = a.valueAt(i) + b.valueAt(i) + carry;
    r.addFirst(sum % 2);
    carry = sum ~/ 2;
  }
  if (carry == 1) r.addFirst(1);

  final sb = StringBuffer();
  r.forEach(sb.write);
  return '$sb';
}

extension on String {
  int valueAt(int i) {
    if (i >= length) return 0;
    return int.parse(this[length - 1 - i]);
  }
}

extension _AddFirst<E> on List<E> {
  void addFirst(E value) => insert(0, value);
}

void main() {
  test('leetcode examples', () {
    expect(add('11', '1100000'), '1100011');
    expect(add('11', '11'), '110');
    expect(add('11', '1'), '100');
    expect(add('1010', '1011'), '10101');
  });
}
