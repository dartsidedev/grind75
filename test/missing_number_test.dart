import 'package:test/test.dart';

int missingNumber(List<int> values) {
  final n = values.length;
  final expectedSum = n * (n + 1) ~/ 2;
  final sum = values.reduce((s, e) => s + e);
  return expectedSum - sum;
}

void main() {
  group('missingNumber', () {
    test('lc examples', () {
      expect(missingNumber([3, 0, 1]), 2);
      expect(missingNumber([0, 1]), 2);
      expect(missingNumber([9, 6, 4, 2, 3, 5, 7, 0, 1]), 8);
    });
  });
}
