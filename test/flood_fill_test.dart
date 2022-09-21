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
List<List<int>> floodFill(List<List<int>> img, int sy, int sx, int color) {
  final s = Pixel(sx, sy);
  final oldColor = img.getColor(s);
  if (oldColor == color) return img;

  img.setColor(s, color);
  final queue = ListQueue<Pixel>()..addLast(s);

  while (queue.isNotEmpty) {
    final current = queue.removeFirst();
    final neighbors = img.getNeighbors(current);
    for (final neighbor in neighbors) {
      final neighborColor = img.getColor(neighbor);
      if (neighborColor == oldColor) {
        img.setColor(neighbor, color);
        queue.add(neighbor);
      }
    }
  }

  return img;
}


class Pixel {
  Pixel(this.x, this.y);
  
  final int x;
  final int y;
  
  @override
  bool operator==(Object o) => o is Pixel && o.x == x && o.y == y;
  
  @override
  int get hashCode => Object.hash(x, y);
}

extension on List<List<int>> {
  int getColor(Pixel p) => this[p.y][p.x];
  
  void setColor(Pixel p, int c) => this[p.y][p.x] = c;
  
  Iterable<Pixel> getNeighbors(Pixel p) {
    return [
      Pixel(p.x + 1, p.y),
      Pixel(p.x - 1, p.y),
      Pixel(p.x, p.y + 1),
      Pixel(p.x, p.y - 1),
    ].where(isValidPixel);
  }
  
  bool isValidPixel(Pixel p) {
    return 0 <= p.x && p.x < this[0].length && 0 <= p.y && p.y < length;
  }
}


List<List<int>> floodFillRecursive(
  List<List<int>> img,
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

/*
    final xMax = img[0].length, yMax = img.length;

    final initialColor = img[sy][sx];
    if (initialColor == color) return img;

    void dfs(int x, int y) {
      if (x < 0 || xMax <= x) return;
      if (y < 0 || yMax <= y) return;
      if (img[y][x] != initialColor) return;

      img[y][x] = color;
      
      dfs(x + 1, y);
      dfs(x - 1, y);
      dfs(x, y + 1);
      dfs(x, y - 1);
    }

    dfs(sx, sy);

    return img;
*/

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
