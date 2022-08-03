import 'package:test/test.dart';

/// Write a function that takes an unsigned integer and returns the number of
/// '1' bits it has (also known as the Hamming weight).
///
/// Note:
///
/// Note that in some languages, such as Java, there is no unsigned integer
/// type. In this case, the input will be given as a signed integer type.
/// It should not affect your implementation, as the integer's internal binary
/// representation is the same, whether it is signed or unsigned.
/// In Java, the compiler represents the signed integers using 2's complement
/// notation. Therefore, in Example 3, the input represents the signed integer. -3.
int numberOf1Bits(int value) {
  var counter = 0;

  while (value != 0) {
    if ((value & 1) == 1) counter++;
    value >>= 1;
  }

  return counter;
}

void main() {
  test('lc', () {
    expect(numberOf1Bits(11), 3);
    expect(numberOf1Bits(16), 1);
  });

  test('more examples', () {
    expect(numberOf1Bits(1), 1);
    expect(numberOf1Bits(2), 1);
    expect(numberOf1Bits(3), 2);
    expect(numberOf1Bits(4), 1);
    expect(numberOf1Bits(5), 2);
    expect(numberOf1Bits(6), 2);
    expect(numberOf1Bits(7), 3);
  });
}
