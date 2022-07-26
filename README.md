# Grind 75 in Dart

> All the 169 challenges of the Grind 75 LeetCode study plan solved in beautiful, idiomatic Dart.

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
import 'dart:collection'; // Queue
import 'package:collection/collection.dart'; // firstOrNull

extension QueueStack<E> on Queue<E> {
  void push(E value) => addLast(value);
  E pop() => removeLast(); // throws StateError if empty!
  // For most problems, peek is not needed.
  E? peek() => firstOrNull;
}
```

#### Regex

```dart
bool get isAlphaNumericChar => RegExp(r'^[\w\d]$').hasMatch(this); // or RegExp(r'^[a-zA-Z0-9]$')
```

#### ASCII code units

```dart
  bool get isAlphaNumericChar {
    final codeUnit = codeUnitAt(0);
    final isNumber = 48 <= codeUnit && codeUnit <= 57;
    final isUpperCase = 65 <= codeUnit && codeUnit <= 90;
    final isLowerCase = 97 <= codeUnit && codeUnit <= 122;
    return isNumber || isLowerCase || isUpperCase;
  }
```

## About the solutions

## Challenges

Below you can find a list of challenges that I already solved.

Following [Neetcode's advice](https://www.youtube.com/watch?v=SVvr3ZjtjI8), I summarize each challenge's core concepts and different ways to solve the challenges with its pros and cons.

<details>
<summary>Two Sum</summary>

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
</details>



<details>
<summary>Valid Parentheses</summary>

> [Solution in Dart](https://github.com/dartsidedev/grind75/blob/main/test/valid_parentheses_test.dart) - [LeetCode - Two Sum](https://leetcode.com/problems/valid-parentheses/)

Push items to a stack when parenthesis/bracket is opening.
Pop off when closing, and make sure they are matching.
Don't forget to check at the end if the stack is empty.
Remember to pop off only if stack is not empty (or use peek).
</details>



<details>
<summary>Merge Two Sorted Lists</summary>

> [Solution in Dart](https://github.com/dartsidedev/grind75/blob/main/test/merge_two_sorted_lists_test.dart) - [LeetCode - Merge Two Sorted Lists](https://leetcode.com/problems/merge-two-sorted-lists/)

Trick: pre-head pointer significantly simplifies the algorithm.
While both lists are not empty, pick one off the lists and add to the results.
Move pointer.
Do not forget to add the remaining items of the longer list to the list.
Return the pre-head's next as result.

Consider empty nodes.
</details>



<details>
<summary>Valid Palindrome</summary>

> [Solution in Dart](https://github.com/dartsidedev/grind75/blob/main/test/valid_palindrome_test.dart) - [LeetCode - Valid Palindrome](https://leetcode.com/problems/valid-palindrome/)

Obvious solution: filter invalid characters, keep only alphanumeric characters and convert to lowercase (`split`+`where`+`map`+`join`).
Then, check if palindrome: either two pointers, or reverse the string and compare against filtered values.

Improvement: Start with two pointers, if a letter is not alphanumeric, move pointer to next alphanumeric.
Whenever the two pointers contain alphanumeric chars, compare. If the values for the two pointers don't match, return "not a palindrome".

</details>




## Misc

### Coding conventions

In some cases, I do not follow the official Dart style guide
(or other rules that in most popular linting libraries are required).
You can find below the list of rules that I do not follow with a reason as to why that is.

* `curly_braces_in_flow_control_structures`: sometimes I don't want to "spend" three lines just to write a simple `while` loop.
* `avoid_multiple_declarations_per_line`: sometimes two declarations just "belong together"

### Save your completed questions

```js
console.log(JSON.stringify(JSON.parse(localStorage.getItem('1:completedQuestions')), null, 2));
```