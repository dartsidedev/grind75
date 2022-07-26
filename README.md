# Grind 75 in Dart

> All the 169 challenges of the [Grind 75](https://www.techinterviewhandbook.org/grind75) (similar to [Blind 75](https://leetcode.com/discuss/general-discussion/460599/blind-75-leetcode-questions)) [LeetCode](https://leetcode.com/) study plan solved in beautiful, idiomatic [Dart](https://dart.dev/)

You can find all the questions and solutions in the [`test`](https://github.com/dartsidedev/grind75/tree/main/test) folder.

## Resources

* [Grind 75](https://www.techinterviewhandbook.org/grind75)
* [Blind 75](https://leetcode.com/discuss/general-discussion/460599/blind-75-leetcode-questions)
* [LeetCode](https://leetcode.com/)
* [Dart](https://dart.dev/)
  * [Language Tour](https://dart.dev/guides/language/language-tour)
  * [Effective Dart](https://dart.dev/guides/language/effective-dart)

## Cheat sheet

Here, I summarize the core ideas, Dart syntax, data structures or algorithms that I keep forgetting.

#### Stack

```dart
extension QueueStack<E> on Queue<E> {
  void push(E value) => addLast(value);
  E pop() => removeLast(); // throws StateError if empty!
  E? peek() => firstOrNull;
}
```

## About the solutions

## Challenges

Below you can find a list of challenges that I already solved.

Following [Neetcode's advice](https://www.youtube.com/watch?v=SVvr3ZjtjI8), I summarize each challenge's core concepts and different ways to solve the challenges with its pros and cons. 

### Two Sum

> [Solution in Dart](https://github.com/dartsidedev/grind75/blob/main/test/two_sum_test.dart) - [LeetCode - Two Sum](https://leetcode.com/problems/two-sum/)

> input: exactly one solution. You may not use the same element twice.

Iterate over numbers: store in map: number is the key, index is the value.
As you iterate, look up in the map whether the current number has a complement in the map that adds up to target, return indices if it's a solution.
If the current number and none of the map entries add up to the target number, add the number to the map.
Continue until solution is found.

Complexity. Time O(n), as you might iterate over the whole list. Space O(n) you need a map.

Other solutions:
1. Brute force: double loop, return when hit target. Time O(n^2), space O(1).
2. [Sort list](https://leetcode.com/problems/two-sum-ii-input-array-is-sorted) first, then two pointers. Need to keep track of the original indices or need to use new list, though, extra space!

### Valid Parentheses

> [Solution in Dart](https://github.com/dartsidedev/grind75/blob/main/test/valid_parentheses_test.dart) - [LeetCode - Two Sum](https://leetcode.com/problems/valid-parentheses/)

Push items to a stack when parenthesis/bracket is opening.
Pop off when closing, and make sure they are matching.
Don't forget to check at the end if the stack is empty.
Remember to pop off only if stack is not empty.

## Misc

### Save your completed questions

```js
console.log(JSON.stringify(JSON.parse(localStorage.getItem('1:completedQuestions')), null, 2));
```