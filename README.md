# Grind 75 in Dart

> All`*` the 169 challenges of the Grind 75 LeetCode study plan solved in beautiful, idiomatic Dart.

`*`: Well, not yet, but I am on it! 🚀

You can find all the questions and solutions in the [`test`](https://github.com/dartsidedev/grind75/tree/main/test)
folder.

## Resources

* [Grind 75](https://www.techinterviewhandbook.org/grind75)
* [Blind 75](https://leetcode.com/discuss/general-discussion/460599/blind-75-leetcode-questions)
* [LeetCode](https://leetcode.com/)
* [Dart](https://dart.dev/)
    * [Language Tour](https://dart.dev/guides/language/language-tour)
    * [Effective Dart](https://dart.dev/guides/language/effective-dart)

## Important todos

* All sorting algorithms. What's a good default? What is used by Dart (and other progr. languages)? Faster than nlogn?

## Cheat sheet

Here, I summarize the core ideas, Dart syntax, data structures or algorithms that I keep forgetting.

### Sorting

You can find the default implementation of `List.sort`
in [`github.com/dart-lang`'s `sdk/lib/internal/sort.dart`](https://github.com/dart-lang/sdk/blob/main/sdk/lib/internal/sort.dart)
.

It's the dual-pivot quicksort algorithm as presented in
[Vladimir Yaroslavskiy's paper](https://codeblab.com/wp-content/uploads/2009/09/DualPivotQuicksort.pdf).
It uses two pivot elements (so partitions to three parts).

The dual pivot quicksort algorithm reduces the average number of swaps
by [20%](https://www.reddit.com/r/programming/comments/9jj5z/vladimir_yaroslavskiys_dualpivot_quicksort/).
The average number of comparisons stays the same.

On average, it takes $O(n \log n)$ comparisons, in the worst case $O(n^2)$.

For lists with a length less than 32, Dart uses [insertion sort](https://en.wikipedia.org/wiki/Insertion_sort), $O(n^2)
$.

### Queue

A `Queue` is a collection that can be manipulated at both ends.

Its implementers, `DoubleLinkedQueue` and `ListQueue`, are efficient for queue or stack usage.

```dart
// Queue, DoubleLinkedQueue, ListQueue
import 'dart:collection';
```

The `DoubleLinkedQueue` is an implementation of the `Queue` based on a double-linked list.
It allows **constant time add, remove-at-ends and peek operations**.

```dart

final doubleLinkedQueue = DoubleLinkedQueue<int>();
```

The `ListQueue` is a list based `Queue`.
It keeps a cyclic buffer of elements, and grows to a larger buffer when it fills up.
This guarantees **constant time peek and remove operations, and amortized constant time add operations**.

```dart

final initialCapacity = 16; // Default init capacity is 8.
final listQueue = ListQueue<int>(initialCapacity);
```

| | add (to ends) | remove (at ends) | peek |
|---|:-:|:-:|:-:|
| `DoubleLinkedQueue` | $O(1)$ | $O(1)$ | $O(1)$ |
| `ListQueue`  | amortized $O(1)$ | $O(1)$ | $O(1)$ |

**Minimalist extensions for stacks and queues**.

Sometimes, I find that the traditional queue operations come easier, especially if I am under stress and I feel
pressured to be fast and clear while at an interview.

For this reason, I prefer to add the "minimalist" queue and stack static extension methods on the `Queue`.

```dart
extension MinimalistQueue<E> on Queue<E> {
  void enqueue(E value) => addLast(value);

  E dequeue() => removeFirst(); // throws StateError if empty!
  E? peek() => firstOrNull; // For most problems, peek is not needed.
}
```

```dart
extension MinimalistStack<E> on Queue<E> {
  void push(E value) => addLast(value);

  E pop() => removeLast(); // throws StateError if empty!
  E? peek() => lastOrNull; // For most problems, peek is not needed.
}
```

### Regex

```dart
// Assumes string's of length 1
bool get isAlphaNumericChar => RegExp(r'^[\w\d]$').hasMatch(this);
// or RegExp(r'^[a-zA-Z0-9]$')
```

### ASCII code units

For day-to-day work, knowing and remembering the ASCII code units of different characters is completely useless.

However, in many coding challenges, it can come in handy.

|           |   starts |      ends | count |
|-----------|---------:|----------:|------:|
| numbers   | 48 (`0`) |  57 (`9`) |    10 |
| uppercase | 65 (`A`) |  90 (`Z`) |    26 |
| lowercase | 97 (`a`) | 122 (`z`) |    26 |

For example, if you know that the input is ASCII-only, you can determine very easily
whether a character is alphanumeric using code units.

```dart
// Assumes string's of length 1
bool get isAlphaNumericChar {
  final codeUnit = codeUnitAt(0);
  final isNumber = 48 <= codeUnit && codeUnit <= 57;
  final isUpperCase = 65 <= codeUnit && codeUnit <= 90;
  final isLowerCase = 97 <= codeUnit && codeUnit <= 122;
  return isNumber || isLowerCase || isUpperCase;
}
```

In this example, let's say we know about the input string that it only contains lowercase letters (English alphabet).
If we need to store, for example, a counter for each letter in a list, we can write this static extension getter
to convert from strings to the indices for the list.

```dart
extension CharToIndex on String {
  // Assumes only lowercase and length == 1 
  int get charIndex => codeUnitAt(0) - 97;
}
```

#### Tree traversal

* Preorder: root, left, right
* Post order: left, right, root
* Inorder: left, root, right

#### Binary search

You need to be able to write a binary search in a minute, you don't have 10 minutes to think about edge cases.

TODO: Check card: https://leetcode.com/explore/learn/card/binary-search/

#### Reverse linked list

Must know it well!

### Mix

```dart
import 'dart:math';
final maxValue = max(a, b);
// or
import 'dart:math' as math;
final maxValue = math.max(a, b);
```

```dart
import 'package:collection/collection.dart';

/// Equality on lists.
///
/// Two lists are equal if they have the same length and their elements
/// at each index are equal.
bool match(List<int> a, List<int> b) => const ListEquality().equals(a, b);
```

```dart
// part of dart core

// Check whether two references are to the same object.
external bool identical(Object? a, Object? b);
```

## Disclaimers

### Coding conventions

I do not always follow the official Dart style guide
or rules that are in most popular linting libraries enabled.

You can find below the list of rules that I do not follow with a reason as to why that is.

* `curly_braces_in_flow_control_structures`: I don't want to "spend" three lines just to write a simple `while`, `if`, `for`.
* `avoid_multiple_declarations_per_line`: sometimes two declarations just belong together, and at interviews, you really don't have enough time to declare everything in a new line.

### Test quality

I didn't spend time writing the perfect test description for my tests.
I made sure that I have enough tests to spot any potential mistakes and that I add the examples from LeetCode.

This doesn't mean that in your day job, you should write the tests like I did in this repository,
it just means that I wanted to focus on solving the problem correctly.

Unfortunately, LeetCode doesn't work with Dart, if you want to change that, upvote this issue.
LeetCode doesn't do it for me for Dart).

### Solution descriptions

The solution descriptions are mostly for myself. For cases, where the challenge was very easy for me, I didn't spend
much effort on describing the solution.

## Challenges

Below you can find a list of challenges that I already solved.

Following [Neetcode's advice](https://www.youtube.com/watch?v=SVvr3ZjtjI8), I summarize each challenge's core concepts
and different ways to solve the challenges with its pros and cons.

<details>
<summary><b>Two Sum</b> 🏷 <i>array</i></summary>

> [Solution](./test/two_sum_test.dart)
> [LeetCode](https://leetcode.com/problems/two-sum/)

> Exactly one solution. You may not use the same element twice.
> Return indices of the two numbers such that they add up to target.

We need to return the indices.
Create a map where _the key is the number value_ and _the value is its index_.

Iterate over numbers: store visited numbers and their indices in the map.

As you iterate, check whether current number has a _complement_ in the map that adds up to target.
If it does, return the indices.
If it doesn't, add number to the map.

**Complexity analysis**: $n$ is the number of elements in the list.
* **Time complexity**: $O(n)$, as you might iterate over the whole list.
* **Space complexity**: $O(n)$, as you might need to store almost all elements and their indices in the map.

Other solutions:

* **Brute force**: double loop, return when the two numbers add up to the target.
  * **Time complexity**: $O(n^2)$, for each of $n$ elements, we try to find its complement by looping through the rest of the list. 
  * **Space complexity**: $O(1)$, no extra space that depends on the input size is necessary.
* [Sort list](https://leetcode.com/problems/two-sum-ii-input-array-is-sorted) first, then on a sorted list, find values with two pointers (from start and end).
  * **Time complexity**: $O(n \log n)$, because sort $O(n \log n)$ + two pointers $O(n)$.
  * **Space complexity**: $O(n)$, sort and two-pointers would be possible with $O(1)$, but we need to store original indices $O(n)$.
  * This solution, as the list is not already sorted and we need to return the original indices, is fairly complicated, and doesn't perform too well (neither in space nor time complexity).
</details>



<details>
<summary><b>Valid Parentheses</b> 🏷 <i>stack</i></summary>

> [Solution](./test/valid_parentheses_test.dart)
> [LeetCode](https://leetcode.com/problems/valid-parentheses/)

> input string consists of parentheses/brackets only `()[]{}`

Push opening parenthesis/bracket to a stack.
Pop off when closing, and make sure they are matching.
Don't forget to check at the end if the stack is empty.
Remember to pop off only if stack is not empty (or use peek).

**Complexity analysis**: $n$ is the length of the input string.
* **Time complexity**: $O(n)$, as you iterate over the whole input string, and potentially adding half of them to a stack. Pushing and popping on a stack can be a $O(1)$ operation if the stack is efficient.
* **Space complexity**: $O(n)$, we need a stack that might contain $n$ elements.

[Solution variant](https://leetcode.com/problems/valid-parentheses/discuss/500491/Rust-0ms), you could immediately push the closing parenthesis onto the stack, it actually ends up looking pretty nice.
</details>



<details>
<summary><b>Merge Two Sorted Lists</b> 🏷 <i>linked list</i></summary>

> [Solution](./test/merge_two_sorted_lists_test.dart)
> [LeetCode](https://leetcode.com/problems/merge-two-sorted-lists/)

_Trick: pre-head pointer significantly simplifies the iterative algorithm._

While both lists are not empty, pick one off the lists and add to the results.
Move pointer.
Do not forget to add the remaining items of the longer list to the list.
Return the pre-head's next as result.

Consider empty nodes. Do not assume the two lists are of equal length.

**Complexity analysis**, $n$ and $m$ are the lengths of the input linked lists:
* **Time complexity**: $O(n+m)$ (linear with total length), because we simply iterate over both lists and picking the correct.
* **Space complexity**: $O(1)$, only need a couple of variables, constant space, and the returned list consists of nodes already created before the solution algorithm ran.

Alternative solutions:
* Recursive solution. Basically the same, just with different space complexity due to the stack.
</details>



<details>
<summary><b>Best Time to Buy and Sell Stock</b> 🏷 <i>array</i></summary>

> [Solution](./test/best_time_to_buy_and_sell_stock_test.dart)
> [LeetCode](https://leetcode.com/problems/best-time-to-buy-and-sell-stock/)

_Clarify at the interview_:
* What is the input, `int` vs `num` vs `double`? In this case, we work with `int`.
* Can it be negative/positive? It doesn't affect the algorithm.
* What should the solution return if it is impossible to achieve any profit? Return 0 if no profit possible.

Keep track of min price "so far".
Current profit is price minus the min price so far.
Update max profit if current profit greater.
Handle negative profit edge case (must return 0).

**Complexity analysis**, $n$ is the length of the list:
* **Time complexity**: $O(n)$, as you iterate over the whole list in a single pass.
* **Space complexity**: $O(1)$, because you only need two variables holding integers.

Alternative solutions:
* brute force: double loop, calculate profit for each possible pair.
  * **Time complexity**: $O(n^2)$, for each number, sweep the rest of the list.
  * **Space complexity**: $O(1)$.
</details>



<details>
<summary><b>Valid Palindrome</b> 🏷 <i>string</i></summary>

> [Solution](./test/valid_palindrome_test.dart)
> [LeetCode](https://leetcode.com/problems/valid-palindrome/)

Start with two pointers at each end of the string.
If a letter is not alphanumeric, move pointer to next alphanumeric.
Whenever the two pointers contain alphanumeric chars, compare.
If the values for the two pointers don't match, return "not a palindrome".

**Complexity analysis**, $n$ is the length of the string:
* **Time complexity**: $O(n)$, as we traverse over each character at most once.
* **Space complexity**: $O(1)$, because you only need two variables holding integers.

Alternative solutions:

* filter and transform invalid characters (keep only alphanumeric characters and convert to lowercase)
  (`split`+`where`+`map`+`join`).
  Then, check if palindrome: either two pointers, or reverse the string and compare against filtered values. TODO: I could actually implement this one day.
</details>

<details>
<summary><b>Invert Binary Tree</b> 🏷 <i>binary tree</i></summary>

> [Solution](./test/invert_binary_tree_test.dart)
> [LeetCode](https://leetcode.com/problems/invert-binary-tree/)

> The inverse of a tree with root $R$, and subtrees $r$ and $l$, is a tree with root $R$, whose
> right subtree is the inverse of $l$, and whose left subtree is the inverse of $r$.

Invert tree recursively. Swap children, then invert left and right subtrees. Handle null case.

Both pre-order and post-order traversal give the right answer.

**Complexity analysis**, $n$ is the number of the nodes in the tree:
* **Time complexity**: $O(n)$, we visit each node once.
* **Space complexity**: $O(n)$, the recursion stack will be as high as the tree, which in the worst case is equal to the number of nodes.

TODO: Solve iteratively, both post and preorder.
</details>



<details>
<summary><b>Valid Anagram</b> 🏷 <i>string</i></summary>

> [Solution](./test/valid_anagram_test.dart)
> [LeetCode](https://leetcode.com/problems/valid-anagram/)

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

> [Solution](./test/binary_search_test.dart)
> [LeetCode](https://leetcode.com/problems/binary-search/)

Learn to write binary search, it doesn't really get much simpler than that.
Pay attention to empty list, first element, last element. Practice templates.
</details>



<details>
<summary><b>Flood Fill</b> 🏷 <i>graph</i></summary>

> [Iterative Solution in Dart](./test/flood_fill_test.dart)
> [LeetCode](https://leetcode.com/problems/flood-fill/)

Depth-first search, either iteratively or recursively.

Complexity.
n is the number of pixels in the image.
Time Complexity O(n) as we might process every pixel.
Space Complexity O(n) for the stack (either call stack for recursive or queue/stack for the iterative solution).
</details>



<details>
<summary><b>Maximum Subarray</b> 🏷 <i>dynamic programming</i></summary>

> [Solution](./test/maximum_subarray_test.dart)
> [LeetCode](https://leetcode.com/problems/maximum-subarray/)

Solutions:

* TC O(n^3). Three loops: two for moving the indices, one for calculating the sum
* TC O(n^2). One for moving the start index, the other one for the end index and continuously updating the sum in the
  line. Biggest sum wins in the end.
* TC O(n). Kadane (greedy?). Iterate over items. Keep track of max and "current max". When single item is better than
  the single item + previous, use only single item. No indices needed.
* TC O(n log n), SC O(log n).

TODO: Divide and Conquer
</details>




<details>
<summary><b>Lowest Common Ancestor of a Binary Search Tree</b> 🏷 <i>binary search tree</i></summary>

> [Solution](./test/lowest_common_ancestor_of_a_binary_search_tree_test.dart)
> [LeetCode](https://leetcode.com/problems/lowest-common-ancestor-of-a-binary-search-tree/)

Solution. If both input values are smaller than current, go to the left, if both bigger, go to the right.
If one is smaller, the other one is bigger, it's an LCA.
If current value matches, it's an LCA.  (the two LCA conditions can be "fused" into one, if you really want to)
</details>



<details>
<summary><b>Balanced Binary Tree</b> 🏷 <i>binary tree</i></summary>

> [Solution](./test/balanced_binary_tree_test.dart)
> [LeetCode](https://leetcode.com/problems/balanced-binary-tree/)

Solutions. Iterative, recursive.

> a binary tree in which the left and right subtrees of every node differ in height by no more than 1.

Get the height of the left and right subtrees. Use -1 to show that it is not balanced.

TODO: Iterative
</details>



<details>
<summary><b>Implement Queue using Stacks</b> 🏷 <i>stack</i></summary>

> [Solution](./test/implement_queue_using_stacks_test.dart)
> [LeetCode](https://leetcode.com/problems/implement-queue-using-stacks/)

Have two stacks, and a phase internally whether we were pushing or popping off the queue.
When changing phases, move all items from one stack to another first, then add or remove.
</details>



<details>
<summary><b>Linked List Cycle</b> 🏷 <i>linked list</i></summary>

> [Solution](./test/linked_list_cycle_test.dart)
> [LeetCode](https://leetcode.com/problems/linked-list-cycle/)

Solutions:

* Iterate over linked list and store seen nodes in a map. If node is already seen, return that it has a cycle. If
  reaches the end of the list, it has no cycles. TC O(n), SC O(n)
* Double pointers. Fast and slow pointers. Fast moves two at a time, slow moves one at a time. if they "meet", it's a
  cycle. Careful with the stop condition.

</details>



<details>
<summary><b>First bad version</b> 🏷 <i>binary search</i></summary>

> [Solution](./test/first_bad_version_test.dart)
> [LeetCode](https://leetcode.com/problems/first-bad-version/)

Learn to write binary search, it doesn't really get much simpler than that.
Pay attention to empty list, first element, last element. Practice templates.
</details>



<details>
<summary><b>Ransom Note</b> 🏷 <i>hash table</i></summary>

> [Solution](./test/ransom_note_test.dart)
> [LeetCode](https://leetcode.com/problems/ransom-note/)

For letter frequency counter, use map for unicode, use list of length 26 for ASCII lowercase.

Simple solution:
You can use two maps/lists as frequency counters, then check whether the magazine's counters are highers for each
position than in the ransom note.

Alternatives.
Terminate early (earlier?): Start with one map for the magazine, then start removing letters based on the ransom note.
Whenever your magazines hit 0 counts, return false.
Alternative II. You can also sort and compare, sort and put it into a stack, etc...
</details>



<details>
<summary><b>Climbing Stairs</b> 🏷 <i>dynamic programming</i></summary>

> [Solution](./test/climbing_stairs_test.dart)
> [LeetCode](https://leetcode.com/problems/climbing-stairs/)

It's Fibonacci's twin sister.
</details>



<details>
<summary><b>Longest Palindrome</b> 🏷 <i>string</i></summary>

> [Solution](./test/longest_palindrome_test.dart)
> [LeetCode](https://leetcode.com/problems/longest-palindrome/)

Build letter counter (frequency).
Know your code units: A for 65, Z for 90, a for 97, z for 122.
Alternatively, use a map.

We can use letters in pairs to build the palindrome length (use int division by 2).
Then, if there was an odd letter, we can add it to the middle (counts as +1).
</details>


<details>
<summary><b>Reverse Linked List</b> 🏷 <i>linked list</i></summary>

> [Solution](./test/reverse_linked_list_test.dart)
> [LeetCode](https://leetcode.com/problems/reverse-linked-list/)

Helpful: pre-head!
TODO: check my past solutions, one of them must be intuitive enough to remember and solve in 3 minutes.
</details>



<details>
<summary><b>Majority Element</b> 🏷 <i>array</i></summary>

> [Solution](./test/majority_element_test.dart)
> [LeetCode](https://leetcode.com/problems/majority-element/)

Potential solutions

* Double loop: Count how often the element is in the list, if it's greater than half, it's the solution. TC O(n^2), SC:
  O(1).
* Sort, then sweep for greatest. Sort TC O(n log n), SC O(1). Sweep TC O(n), SC O(1). Total: TC O(n log n), SC O(1).
    * Improvement: once sorted, we don't need to sweep. It's always the middle element.
* Store counter in map, if majority, return. TC O(n), SC O(n).
* Random: Pick an index randomly, there is at least a 50% chance it will be the majority item. O(n) to verify. Repeat
  until found. Worst case scenario: infty.

TODO:

* Boyer-Moore
* Divide and Conquer

</details>



<details>
<summary><b>Add Binary</b> 🏷 <i>binary</i></summary>

> [Solution](./test/add_binary_test.dart)
> [LeetCode](https://leetcode.com/problems/add-binary/)

Add Binary.
</details>




<details>
<summary><b>Middle of the Linked List</b> 🏷 <i>linked list</i></summary>

> [Solution in Dart (two pointers)](./test/middle_of_the_linked_list_test.dart)
> [LeetCode](https://leetcode.com/problems/middle-of-the-linked-list/)

Potential solutions:

* First pass: count elements. Second pass: go to the middle. TC O(n), SC O(1)
* One-pass algorithm: two pointers, slow and fast. When fast is at the end, slow is in the middle.

</details>



<details>
<summary><b>Contains duplicate</b> 🏷 <i>array</i></summary>

> [Solution](./test/contains_duplicate_test.dart)
> [LeetCode](https://leetcode.com/problems/contains-duplicate/)

Potential solutions:

* brute force: double loop. TC O(n^2), SC O(1)
* sort then look for duplicates. TC O(n log n + n), SC O(1). Mutates input! (or if it doesn't mutate, then it needs a
  copy O(n))
* store seen in map, iterate over elements and check if already seen. TC O(n), SC O(n). Does not mutate input.

</details>



<details>
<summary><b>Roman to Integer</b> 🏷 <i>math</i></summary>

> [Solution](./test/roman_to_integer_test.dart)
> [LeetCode](https://leetcode.com/problems/roman-to-integer/)

Keep track of value so far.
Iterate over the string.
Check if the next two characters make up an exception. If they do: add to value, skip next char.
If they don't: treat first char as regular, add to value.

Alternative solutions: [Left to Right](https://www.youtube.com/watch?v=3jdxYj3DD98)
. [Right to Left](https://www.youtube.com/watch?v=dlATMslQ6Uc).
</details>



<details>
<summary><b>Single Number</b> 🏷 <i>binary</i></summary>

> [Solution](./test/single_number_test.dart)
> [LeetCode](https://leetcode.com/problems/single-number/)

> every element appears twice except for one

Solutions:

* Iter over items: if in second array, remove the item, if it isn't, add the item. In the end, only the single number
  will stay
* Build map of frequencies. Iterate over map entries, find where value is 1, return key. TC O(n), SC O(n) (this
  complexity is not accepted according to the answer)
* "Bit xor" `^` all the way. Can reduce or loop.
* math: 2 * (a1 + a2 + ... + an + b) - (a1 + a1 + ... + an + an + b) = b. Sum up all items in list. Then add all items
  in a set, sum up, double it. The diff is the number.

</details>



<details>
<summary><b>Missing Number</b> 🏷 <i>binary</i></summary>

> [Solution](./test/missing_number_test.dart)
> [LeetCode](https://leetcode.com/problems/missing-number/)

Solutions:

* Sort TC O(n log n), then find missing TC O(n).
* Bit xor again! `^`. Xor together all the numbers, then xor with n. The result is the missing number.
* Calculate expected sum, calculate actual sum, the diff is the missing number
    * expected sum can be either calculated O(n), or use Gauss formula

</details>


<details>
<summary><b>Palindrome Number</b> 🏷 <i>math</i></summary>

> [Solution](./test/palindrome_number_test.dart)
> [LeetCode](https://leetcode.com/problems/palindrome-number/)

First approach: convert to string, then solve it as if was a string.

Second approach: convert it to a list, then solve it as if it were a list. Use `%` and `~/`.

Third approach: get the last and first digits. Transform the input. Repeat. Return false if they don't match.

Fourth approach: create reverted number, then compare integers.
</details>



<details>
<summary><b>Squares of a Sorted Array</b> 🏷 <i>array</i></summary>

> [Solution](./test/squares_of_a_sorted_array_test.dart)
> [LeetCode](https://leetcode.com/problems/squares-of-a-sorted-array/)

Must consider possible negative numbers!

Very brute force solution (does not mutate input): Map square (TC: O(n), SC: O(n)), sort (TC: O(n log n), SC: O(1)).

Brute force solution (mutates input, no extra space at all): Square each number in place (TC: O(n), SC: O(1)), sort the
list (TC: O(n log n), SC: O(1)).

Two-pointer solution: from one of the two ends of the list will come the next biggest square (postive, negative numbers)
.
Move two pointers, and the biggest square will be added to a list. You can create a fixed size list beforehand, in this
case, the list will be filled from the end (largest) to the start (smallest).
Complexity: O(n), space O(1) (if we count the output: O(n)).
</details>




<details>
<summary><b>K Closest Points to Origin</b> 🏷 <i>heap</i></summary>

> [Solution](./test/k_closest_points_to_origin_test.dart)
> [LeetCode](https://leetcode.com/problems/k-closest-points-to-origin/)

* Helpful math knowledge: do not need sqrt, just use "x * x + y * y"
* Align with interviewer: could the return value be an Iterable?

Possible solutions:

* Total brute force: double loop: when smallest item found, remove it from list, copy into results.
* Sort list by "square sums" TC O(n log n), SC O(1). Copy first k elements into a list TC O(k), SC O(k)
* Add all elements into a min heap TC O(n), SC O(n). "Pop off" the smallest k elements TC O(k log n) (result could be an
  iterable, not necessarily a list)
* Add k elements into a max heap. After the kth, every time you add something into the heap, pop off the largest value.
  At the end, add remaining items to the result (either as list or iterable).
* TODO: Quick Select

</details>

<details>
<summary><b>Backspace String Compare</b> 🏷 <i>stack</i></summary>

> [Solution](./test/backspace_string_compare_test.dart)
> [LeetCode](https://leetcode.com/problems/backspace-string-compare/)

* build two stacks based on inputs: if `#`, pop off the stack. Then, compare the two stacks: check length first, then
  pop the items of and if there is no match, return false. TC O(n), SC O(n)
* iterate from the end. If `#`, continue. Char-generator function, for both, get next, compare. TC O(n), SC O(1)

</details>


<details>
<summary><b>Number of 1 Bits</b> 🏷 <i>binary</i></summary>

> [Solution](./test/number_of_1_bits_test.dart)
> [LeetCode](https://leetcode.com/problems/number-of-1-bits/)

Go over the binary operators and you will be fine.
</details>


<details>
<summary><b>Maximum Depth of Binary Tree</b> 🏷 <i>binary tree</i></summary>

> [Solution](./test/maximum_depth_of_binary_tree_test.dart)
> [LeetCode](https://leetcode.com/problems/maximum-depth-of-binary-tree/)

Recursive, iterative solutions. Depth = max(left, right) + 1.
</details>



<details>
<summary><b>Diameter of a Binary Tree</b> 🏷 <i>binary tree</i></summary>

> [Solution](./test/diameter_of_a_binary_tree_test.dart)
> [LeetCode](https://leetcode.com/problems/diameter-of-binary-tree/)

Calculate height for each node: height = max(left, right) + 1.
Calculate diameter for each node: diameter = leftHeight + rightHeight.
While calculating the heights and diameters, update "max diameter".

Do it recursively, and iteratively.

Iterative postorder traversal is easy with two stack (though also possible with one), and you keep track of heights in
map of nodes to heights.

</details>


<details>
<summary><b>Counting bits</b> 🏷 <i>binary</i></summary>

> [Solution](./test/counting_bits_test.dart)
> [LeetCode](https://leetcode.com/problems/countings-bits/)

Solutions:

* number of bits, n times...
* TODO: understand and solve all the other solutions

</details>



<details>
<summary><b>Same tree</b> 🏷 <i>binary tree</i></summary>

> [Solution](./test/same_tree_test.dart)
> [LeetCode](https://leetcode.com/problems/same-tree/)

Solutions:

* override ==
* recursive
* iterative (use stack)

</details>



<details>
<summary><b>Subtree of Another Tree</b> 🏷 <i>binary tree</i></summary>

> [Solution](./test/subtree_of_another_tree_test.dart)
> [LeetCode](https://leetcode.com/problems/subtree-of-another-tree/)

Solutions:

* See same tree for comparing two trees. Traverse the tree and check each node.

</details>


<details>
<summary><b>Reverse Bits</b> 🏷 <i>binary</i></summary>

> [Solution](./test/reverse_bits_test.dart)
> [LeetCode](https://leetcode.com/problems/reverse-bits)

Get rightmost bit of the value and add it to the result.
Then shift the input value to the right and shift the result to the left.

Reminder: know your [bitwise operators](https://www.tutorialspoint.com/dart_programming/dart_programming_operators.htm):
AND, OR, XOR, NOT, left and right shifts.

According to [Numbers in Dart](https://dart.dev/guides/language/numbers):

> Depending on the platform, those numeric types (`int` and `double`) have different, hidden implementations.
> In particular, Dart has two very different types of targets it compiles to:
> **native** (most often, a 64-bit mobile or desktop processor)
> and **web** (JavaScript as the primary execution engine).

Keep in mind that on JavaScript, that "JavaScript converts numbers into 32 bits before the implementation of bitwise
operators"
which can lead to [surprising behavior](https://stackoverflow.com/a/73471501/4541492).

</details>

<details>
<summary><b>Evaluate Reverse Polish Notation</b> 🏷 <i>stack</i></summary>

> [Solution](./test/evaluate_reverse_polish_notation_test.dart)
> [LeetCode](https://leetcode.com/problems/evaluate-reverse-polish-notation/)

Iterate over input.
If it's a number, add to stack.
If it's an operation, perform operation on top 2 items in the stack, and push result back to stack.

**Complexity analysis**.
$n$ is the length of the input list.
**Time complexity**: $O(n)$, as you iterate over the whole list in a single pass. Pushing to and popping off the stack
is $O(1)$.
**Space complexity**: $O(n)$, as the supporting stack can never be more than half the length of the input.

</details>

<details>
<summary><b>Sort Colors</b> 🏷 <i>array</i></summary>

> [Solution](./test/sort_colors_test.dart)
> [LeetCode](https://leetcode.com/problems/sort-colors/)

If we could use Dart's built-in sorting algorithm, it's a one-liner: dual pivot quicksort $O(n \log n)$ average case,
$O(n^2)$ worst case.

We know that the possible values can only be 0, 1, 2, therefore,
we can use [counting sort](https://en.wikipedia.org/wiki/Counting_sort).

**Complexity analysis**.
$n$ is the length of the input list.
**Time complexity**: $O(n)$, as you iterate over the whole list first to count, then to overwrite.
**Space complexity**: $O(1)$, as we only need three supporting counter variables.

TODO: There is another one-pass solution I didn't check. Dutch flag.
</details>

## Misc

### Save your completed questions

```js
console.log(JSON.stringify(JSON.parse(localStorage.getItem('1:completedQuestions')), null, 2));
```