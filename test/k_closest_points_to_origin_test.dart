import 'dart:math';

import 'package:collection/collection.dart';
import 'package:test/test.dart';

/// Given an array of points where points[i] = [xi, yi]
/// represents a point on the X-Y plane and an integer k, return the
/// closest points to the origin (0, 0).
///
/// The distance between two points on the X-Y plane is
/// the Euclidean distance (i.e., √(x1 - x2)2 + (y1 - y2)2).
///
/// You may return the answer in any order.
/// The answer is guaranteed to be unique (except for the order that it is in).

Iterable<Point> kClosest(List<Point> points, int k) sync* {
  // quick select
}

Iterable<Point> kClosestHeapSimple(List<Point> points, int k) sync* {
  final heap = HeapPriorityQueue<Point>(minFirst);
  heap.addAll(points);
  var i = 0;
  while (i < k) {
    yield heap.removeFirst();
    i++;
  }
}

Iterable<Point> kClosestHeapEfficient(List<Point> points, int k) sync* {
  final heap = HeapPriorityQueue<Point>(maxFirst);
  var n = points.length, i = 0;
  while (i < k) heap.add(points[i++]);
  while (i < n)
    heap
      ..add(points[i++])
      ..removeFirst();
  while (heap.isNotEmpty) yield heap.removeFirst();
}

Iterable<Point> kClosestSort(List<Point> points, int k) {
  points.sort(minFirst);
  return points.take(k);
}

extension on double {
  int toSortInt() => this > 0 ? 1 : -1;
}

int minFirst(Point a, Point b) => (a.distance - b.distance).toSortInt();

int maxFirst(Point a, Point b) => (b.distance - a.distance).toSortInt();

class Point {
  const Point(this.x, this.y);

  final int x;
  final int y;

  // This would also be enough, actually, but distance "reads nicer".
  // int get distanceSquared => x * x + y * y;

  double get distance => sqrt(x * x + y * y);

  @override
  bool operator ==(Object o) => o is Point && o.x == x && o.y == y;

  @override
  int get hashCode => Object.hash(x, y);

  @override
  String toString() => 'Point($x, $y)';
}

void main() {
  test('leetcode examples', () {
    expect(
      kClosest(
        [Point(1, 3), Point(-2, 2)],
        1,
      ).toSet(),
      {Point(-2, 2)},
    );
    expect(
      kClosest(
        [Point(3, 3), Point(5, -1), Point(-2, 4)],
        2,
      ),
      {Point(3, 3), Point(-2, 4)},
    );
  });

  test('other examples', () {
    expect(
      kClosest(
        [
          Point(1, 3),
          Point(-2, 2),
          Point(9, 9),
          Point(0, 1),
          Point(-1, 0),
          Point(0, 0),
        ],
        3,
      ).toSet(),
      {Point(0, 0), Point(0, 1), Point(-1, 0)},
    );
    expect(
      kClosest(
        [Point(3, 3), Point(5, -1), Point(-2, 4)],
        3,
      ).toSet(),
      {Point(3, 3), Point(-2, 4), Point(5, -1)},
    );
  });
}
