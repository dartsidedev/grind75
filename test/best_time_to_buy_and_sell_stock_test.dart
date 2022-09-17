import 'dart:math';

import 'package:test/test.dart';

/// You are given an array prices where prices[i] is the price of a given stock
/// on the ith day.
///
/// You want to maximize your profit by choosing a single day to buy one stock
/// and choosing a different day in the future to sell that stock.
///
/// Return the maximum profit you can achieve from this transaction.
/// If you cannot achieve any profit, return 0.
int maxProfit(List<int> prices) {
  // According to constraints, prices is never empty
  // if (prices.isEmpty) return 0;
  var maxProfit = 0, minPrice = prices.first;

  // or if we are pedantic
  // for (int i = 1; i < prices.length; i++) {
  for (final price in prices) {
    minPrice = min(minPrice, price);
    maxProfit = max(maxProfit, price - minPrice);
  }

  return maxProfit;
}

void main() {
  group('maxProfit', () {
    test('LC Example 1', () {
      expect(maxProfit([7, 1, 5, 3, 6, 4]), 5);
    });

    test('LC Example 2', () {
      expect(maxProfit([7, 6, 4, 3, 1]), 0);
    });

    test('length 1', () {
      expect(maxProfit([1]), 0);
    });

    test('increasing', () {
      expect(maxProfit([0, 1, 3, 4, 5, 5, 7, 9]), 9);
    });

    test('another example', () {
      expect(maxProfit([1, 1, 3, 0, 5, 9, 7, 9]), 9);
    });
  });
}
