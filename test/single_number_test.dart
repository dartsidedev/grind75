import 'package:test/test.dart';

int singleNumber(List<int> values) => values.reduce((v, e) => v ^ e);

void main() {
  group('singleNumber', () {
    test('lc examples', () {
      expect(singleNumber([2, 2, 1]), 1);
      expect(singleNumber([4, 1, 2, 1, 2]), 4);
      expect(singleNumber([1]), 1);
    });
  });
}
