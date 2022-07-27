import 'package:test/test.dart';

List<List<int>> floodFill(
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
        ], 1, 1, 2),
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
        ], 0, 0, 0),
        [
          [0, 0, 0],
          [0, 0, 0]
        ],
      );
    });
  });
}
