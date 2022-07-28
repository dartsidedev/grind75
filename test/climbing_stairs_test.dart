import 'package:test/test.dart';

// This is some code-golf level ugly code, I've written it for fun ⛳️

/// You are climbing a staircase. It takes n steps to reach the top.
///
/// Each time you can either climb 1 or 2 steps. In how many distinct ways can you climb to the top?
int climb(int v) => listgen(++v, (i) => i < 2 ? 1 : -1).climb(--v);

extension on List<int> {
  int climb(int v) => this[v] != -1 ? this[v] : climb(v - 1) + climb(v - 2);
}

List<E> listgen<E>(int len, E Function(int) g) => List<E>.generate(len, g);

void main() {
  test('leetcode examples', () {
    expect(climb(2), 2);
    expect(climb(3), 3);
    expect(climb(4), 5);
    expect(climb(5), 8);
  });
}

int climbingStairsRecursive(int v) {
  if (v == 1 || v == 0) return 1;
  return climb(v - 1) + climb(v - 2);
}
