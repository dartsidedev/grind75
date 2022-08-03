import 'dart:collection';

import 'package:test/test.dart';


/// An image is represented by an m x n integer image image
/// where image[i][j] represents the pixel value of the image.
///
/// You are also given a [pixel] and [color].
/// You should perform a flood fill on the image
/// starting from the pixel [pixel].
///
/// To perform a flood fill, consider the starting pixel, plus any pixels
/// connected 4-directionally to the starting pixel of the same color
/// as the starting pixel, plus any pixels connected 4-directionally to
/// those pixels (also with the same color), and so on.
/// Replace the color of all of the aforementioned pixels with color.
///
/// Return the modified image after performing the flood fill.
List<List<int>> floodFill(
  List<List<int>> values,
  Pixel pixel,
  int newColor,
) {
  final image = Image(values);

  final initial = image.getColor(pixel);
  if (initial == newColor) return values;

  image.setColor(pixel, newColor);
  final q = DoubleLinkedQueue<Pixel>()..enqueue(pixel);
  while (q.isNotEmpty) {
    for (final p in image.getNeighborPixelsWithColor(q.dequeue(), initial)) {
      image.setColor(p, newColor);
      q.enqueue(p);
    }
  }

  return values;
}

extension MinimalistQueue<T> on Queue<T> {
  void enqueue(T value) => addLast(value);

  T dequeue() => removeFirst();
}

class Image {
  Image(this._values);

  final List<List<int>> _values;

  int getColor(Pixel pixel) {
    return _values[pixel.y][pixel.x];
  }

  void setColor(Pixel pixel, int newColor) =>
      _values[pixel.y][pixel.x] = newColor;

  // Get the neighbors of [pixel] with [color].
  Iterable<Pixel> getNeighborPixelsWithColor(Pixel pixel, int color) {
    return getNeighbors(pixel).where((p) => getColor(p) == color);
  }

  Iterable<Pixel> getNeighbors(Pixel pixel) {
    final x = pixel.x, y = pixel.y;
    return [
      Pixel(x + 1, y),
      Pixel(x, y + 1),
      Pixel(x - 1, y),
      Pixel(x, y - 1),
    ].where(isValid);
  }

  int get length => _values.length;

  List<int> operator [](int i) => _values[i];

  bool isValid(Pixel pixel) {
    final yMax = length, xMax = this[0].length, x = pixel.x, y = pixel.y;
    return 0 <= x && x < xMax && 0 <= y && y < yMax;
  }

  @override
  String toString() => '$Image($_values)';
}

class Pixel {
  const Pixel(this.x, this.y);

  final int x;
  final int y;

  @override
  String toString() => '$Pixel($x, $y)';
}

List<List<int>> floodFillRecursive(
    List<List<int>> image,
    int sx,
    int sy,
    int newColor,
    ) {
  final xMax = image[0].length - 1, yMax = image.length - 1;

  final initialColor = image[sy][sx];
  if (initialColor == newColor) return image;

  void dfs(int x, int y) {
    if (image[y][x] != initialColor) return;

    image[y][x] = newColor;

    if (0 < x) dfs(x - 1, y);
    if (0 < y) dfs(x, y - 1);
    if (x < xMax) dfs(x + 1, y);
    if (y < yMax) dfs(x, y + 1);
  }

  dfs(sx, sy);

  return image;
}

void main() {
  group('floodFill', () {
    test('LC Example 1', () {
      expect(
        floodFill([
          [1, 1, 1],
          [1, 1, 0],
          [1, 0, 1],
        ], Pixel(1, 1), 2),
        [
          [2, 2, 2],
          [2, 2, 0],
          [2, 0, 1]
        ],
      );
    });

    test('LC Example 2', () {
      expect(
        floodFill([
          [0, 0, 0],
          [0, 0, 0],
        ], Pixel(0, 0), 0),
        [
          [0, 0, 0],
          [0, 0, 0]
        ],
      );
    });
  });
}
