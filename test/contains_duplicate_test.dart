// sort O n log n, then find duplicate O n, no extra space
// map


import 'package:test/test.dart';

bool containsDuplicate(List<int> values) {
  final seen = <int>{};
  for (final v in values) {
    if (seen.contains(v)) return true;
    seen.add(v);
  }
  return false;
}

void main() {
  group('contains duplcate', () {
    test('lc examples', () {
      expect(containsDuplicate([1,2,3,1]), true);
      expect(containsDuplicate([1,2,3,4]), false);
      expect(containsDuplicate([1,1,1,3,3,4,3,2,4,2]), true);
    });

    test('my examples', () {
      expect(containsDuplicate([]), false);
      expect(containsDuplicate([1, 2, 3, 4]), false);
      expect(containsDuplicate([1, 2, 3, 4, 1]), true);
      expect(containsDuplicate([1, 0]), false);
      expect(containsDuplicate([1, 1]), true);
      expect(containsDuplicate([1]), false);
    });
  });

}