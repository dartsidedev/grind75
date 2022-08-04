import 'package:test/test.dart';

List<int> countingBits(int n) {
  int bits(int value) {
    var count = 0;
    while (value > 0) {
      count += value & 1;
      value >>= 1;
    }
    return count;
  }

  return List.generate(n + 1, bits, growable: false);
}

void main() {
  test('leetcode', () {
    expect(countingBits(2), [0, 1, 1]);
    expect(countingBits(5), [0, 1, 1, 2, 1, 2]);
  });
}
