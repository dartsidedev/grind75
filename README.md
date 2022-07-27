# Grind 75 in Dart

> All`*` the 169 challenges of the Grind 75 LeetCode study plan solved in beautiful, idiomatic Dart.

`*`: Well, not yet, but I am on it! 🚀

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

#### Queue

Implementers of `Queue`.

```dart
import 'dart:collection'; // Queue, DoubleLinkedQueue, ListQueue

final q1 = DoubleLinkedQueue<int>();

final initialCapacity = 16; // Default init capacity is 8.
final q2 = ListQueue<int>(initialCapacity);
```

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

#### Tree traversal

* Preorder: root, left, right
* Post order: left, right, root
* Inorder: left, root, right


#### Binary search

You need to be able to write a binary search in a minute, you don't have 10 minutes to think about edge cases.

TODO: Check card: https://leetcode.com/explore/learn/card/binary-search/

## Disclaimers

### Coding conventions

In some cases, I do not follow the official Dart style guide
(or other rules that in most popular linting libraries are required).
You can find below the list of rules that I do not follow with a reason as to why that is.

* `curly_braces_in_flow_control_structures`: sometimes I don't want to "spend" three lines just to write a simple `while` loop.
* `avoid_multiple_declarations_per_line`: sometimes two declarations just "belong together"

### Test quality

Most of the time, I didn't spend time writing the perfect test description for my tests.
This doesn't mean that in your day job, you should write the tests like me, it just means that I wanted to focus on
problem solving (the solution) and making sure that I have enough tests to spot any potential mistakes (as unfortunately LeetCode doesn't do it for me for Dart).

### Solution descriptions

The solution descriptions are mostly for myself. For cases, where the challenge was very easy for me, I didn't spend much effort on describing the solution.

## Challenges

Below you can find a list of challenges that I already solved.

Following [Neetcode's advice](https://www.youtube.com/watch?v=SVvr3ZjtjI8), I summarize each challenge's core concepts and different ways to solve the challenges with its pros and cons.

<details>
<summary><b>Two Sum</b> 🏷 <i>array</i></summary>

> [Solution in Dart](https://github.com/dartsidedev/grind75/blob/main/test/two_sum_test.dart) - [LeetCode - Two Sum](https://leetcode.com/problems/two-sum/)

> input: exactly one solution. You may not use the same element twice.

Iterate over numbers: store in map: number is the key, index is the value.
As you iterate, look up in the map whether the current number has a complement in the map that adds up to target, return indices if it's a solution.
If the current number and none of the map entries add up to the target number, add the number to the map.
Continue until solution is found.

Complexity.
n is the number of elements in the list.
Time O(n), as you might iterate over the whole list.
Space O(n) you need a map.

Other solutions:
1. Brute force: double loop, return when hit target. Time O(n^2), space O(1).
2. [Sort list](https://leetcode.com/problems/two-sum-ii-input-array-is-sorted) first, then two pointers. Need to keep track of the original indices or need to use new list, though, extra space!
</details>



<details>
<summary><b>Valid Parentheses</b> 🏷 <i>stack</i></summary>

> [Solution in Dart](https://github.com/dartsidedev/grind75/blob/main/test/valid_parentheses_test.dart) - [LeetCode - Two Sum](https://leetcode.com/problems/valid-parentheses/)

Push items to a stack when parenthesis/bracket is opening.
Pop off when closing, and make sure they are matching.
Don't forget to check at the end if the stack is empty.
Remember to pop off only if stack is not empty (or use peek).
</details>



<details>
<summary><b>Merge Two Sorted Lists</b> 🏷 <i>linked list</i></summary>

> [Solution in Dart](https://github.com/dartsidedev/grind75/blob/main/test/merge_two_sorted_lists_test.dart) - [LeetCode - Merge Two Sorted Lists](https://leetcode.com/problems/merge-two-sorted-lists/)

Trick: pre-head pointer significantly simplifies the algorithm.
While both lists are not empty, pick one off the lists and add to the results.
Move pointer.
Do not forget to add the remaining items of the longer list to the list.
Return the pre-head's next as result.

Consider empty nodes.
</details>



<details>
<summary><b>Best Time to Buy and Sell Stock</b> 🏷 <i>array</i></summary>

> [Solution in Dart](https://github.com/dartsidedev/grind75/blob/main/test/best_time_to_buy_and_sell_stock_test.dart) - [LeetCode - Best Time to Buy and Sell Stock](https://leetcode.com/problems/best-time-to-buy-and-sell-stock/)

Keep track of min price "so far".
Current profit is price minus the min price so far.
Update max profit if current profit greater.
Handle negative profit edge case (must return 0).

Complexity.
n is the length of the list.
Time O(n), as you iterate over the whole list in a single pass.
Space O(1) as you don't need supporting data structures, only two variables.

Alternative solutions:
* brute force: double loop, calculate profit for each possible pair. TC: O(n^2), SC: O(1).

Clarify: int vs num vs double. 
</details>



<details>
<summary><b>Valid Palindrome</b> 🏷 <i>string</i></summary>

> [Solution in Dart](https://github.com/dartsidedev/grind75/blob/main/test/valid_palindrome_test.dart) - [LeetCode - Valid Palindrome](https://leetcode.com/problems/valid-palindrome/)

Obvious solution: filter invalid characters, keep only alphanumeric characters and convert to lowercase (`split`+`where`+`map`+`join`).
Then, check if palindrome: either two pointers, or reverse the string and compare against filtered values.

Improvement: Start with two pointers, if a letter is not alphanumeric, move pointer to next alphanumeric.
Whenever the two pointers contain alphanumeric chars, compare. If the values for the two pointers don't match, return "not a palindrome".

</details>

<details>
<summary><b>Invert Binary Tree</b> 🏷 <i>binary tree</i></summary>

> [Solution in Dart](https://github.com/dartsidedev/grind75/blob/main/test/invert_binary_tree_test.dart) - [LeetCode - Invert Binary Tree](https://leetcode.com/problems/invert-binary-tree/)

Invert tree recursively: if null, return.
Swap left and right children, then invert left and right subtrees.
Return node.

Both pre-order and post-order traversal give the right answer.

TODO: Solve without recursion.
</details>



<details>
<summary><b>Valid Anagram</b> 🏷 <i>string</i></summary>

> [Solution in Dart](https://github.com/dartsidedev/grind75/blob/main/test/valid_anagram_test.dart) - [LeetCode - Valid Anagram](https://leetcode.com/problems/valid-anagram/)

Return early if lengths don't match. Create frequency counter. Check if frequencies match.

Complexity.
n is the length of the strings.
Time O(n) as we need to iterate over the both strings entirely to create the frequency table.
Space O(1) size stays constant no matter how large n is (even for unicode).

Worth creating a helper class `Frequency` that can be created from a string and then compared against another freq. 

Follow up: unicode? Change how frequencies are stored from fixed length list to hash map.
To fit all potential unicode characters in a list, the list would have to contain 1M+ elements.
That's wasteful if the strings are short (and anything less than a million characters counts as short in this case).
</details>

<details>
<summary><b>Binary Search</b> 🏷 <i>binary search</i></summary>

> [Solution in Dart](https://github.com/dartsidedev/grind75/blob/main/test/binary_search_test.dart) - [LeetCode - Binary Search](https://leetcode.com/problems/binary-search/)

Learn to write binary search, it doesn't really get much simpler than that.
Pay attention to empty list, first element, last element. Practice templates.
</details>



<details>
<summary><b>Flood Fill</b> 🏷 <i>graph</i></summary>

> [Iterative Solution in Dart](https://github.com/dartsidedev/grind75/blob/main/test/flood_fill_test.dart) - [Recursive Solution in Dart](https://github.com/dartsidedev/grind75/blob/main/test/flood_fill_recursive_test.dart) - [LeetCode - Flood Fill](https://leetcode.com/problems/flood-fill/)

Depth-first search, either iteratively or recursively.

Complexity.
n is the number of pixels in the image.
Time Complexity O(n) as we might process every pixel.
Space Complexity O(n) for the stack (either call stack for recursive or queue/stack for the iterative solution).
</details>



<details>
<summary><b>Implement Queue using Stacks</b> 🏷 <i>stack</i></summary>

> [Solution in Dart](https://github.com/dartsidedev/grind75/blob/main/test/implement_queue_using_stacks_test.dart) - [LeetCode - Implement Queue using Stacks](https://leetcode.com/problems/implement-queue-using-stacks/)

Have two stacks, and a phase internally whether we were pushing or popping off the queue.
When changing phases, move all items from one stack to another first, then add or remove.
</details>



<details>
<summary><b>First bad version</b> 🏷 <i>binary search</i></summary>

> [Solution in Dart](https://github.com/dartsidedev/grind75/blob/main/test/first_bad_version_test.dart) - [LeetCode - First Bad Version](https://leetcode.com/problems/first-bad-version/)

Learn to write binary search, it doesn't really get much simpler than that.
Pay attention to empty list, first element, last element. Practice templates.
</details>



<details>
<summary><b>Ransom Note</b> 🏷 <i>hash table</i></summary>

> [Solution in Dart](https://github.com/dartsidedev/grind75/blob/main/test/ransom_note_test.dart) - [LeetCode - Ransom Note](https://leetcode.com/problems/ransom-note/)

For letter frequency counter, use map for unicode, use list of length 26 for ASCII lowercase.

Simple solution:
You can use two maps/lists as frequency counters, then check whether the magazine's counters are highers for each position than in the ransom note.

Alternatives.
Terminate early (earlier?): Start with one map for the magazine, then start removing letters based on the ransom note. Whenever your magazines hit 0 counts, return false.
Alternative II. You can also sort and compare, sort and put it into a stack, etc...

</details>





## Misc

### Save your completed questions

```js
console.log(JSON.stringify(JSON.parse(localStorage.getItem('1:completedQuestions')), null, 2));
```