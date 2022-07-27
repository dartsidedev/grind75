/// Implement a first in first out (FIFO) queue using only two stacks.
/// The implemented queue should support all the functions of a normal queue
/// (push, peek, pop, and empty).


import 'dart:collection' as c;

import 'package:test/test.dart';


abstract class Stack<T> {
  // Pushes element to the top of the stack.
  void push(T value);

  // Removes the element at the top of the stack and returns it.
  T pop();

  // Returns the element at the top of the stack.
  peek();

  // Returns true if the stack is empty, false otherwise.
  bool get isEmpty;
}

abstract class Queue<T> {
  // Pushes element [value] to the back of the queue.
  void push(T value);

  // Removes the element from the front of the queue and returns it.
  T pop();

  // Returns the element at the front of the queue.
  T peek();

  // Returns true if the queue is empty, false otherwise.
  bool get isEmpty;
}

class CollectionStack<T> implements Stack<T> {
  CollectionStack(this._internal);

  final c.Queue<T> _internal;

  @override
  void push(T value) => _internal.addLast(value);

  @override
  T pop() => _internal.removeLast();

  @override
  T peek() => _internal.last;

  @override
  bool get isEmpty => _internal.isEmpty;
}


class DoubleStackQueue<T> implements Queue<T> {
  DoubleStackQueue(this._pushStack, this._popStack,) : _phase = _Phase.push;

  final Stack<T> _pushStack;
  final Stack<T> _popStack;

  _Phase _phase;

  // [phase] is the new phase.
  void _switchPhase(_Phase phase) {
    if (_phase == phase) return;
    if (phase == _Phase.push) {
      while (!_popStack.isEmpty) _pushStack.push(_popStack.pop());
    } else {
      while (!_pushStack.isEmpty) _popStack.push(_pushStack.pop());
    }
    _phase = phase;
  }


  @override
  void push(T value) {
    _switchPhase(_Phase.push);
    _pushStack.push(value);
  }

  @override
  T pop() {
    _switchPhase(_Phase.pop);
    return _popStack.pop();
  }

  @override
  T peek() {
    _switchPhase(_Phase.pop);
    return _popStack.peek();
  }

  @override
  bool get isEmpty => _pushStack.isEmpty && _popStack.isEmpty;
}

enum _Phase { push, pop }

void main() {
  group('implement queue using stacks', () {
    test('fifo', () {
      final queue = DoubleStackQueue<int>(
        CollectionStack(c.ListQueue()),
        CollectionStack(c.ListQueue()),
      );

      expect(queue.isEmpty, true);

      queue.push(1);
      queue.push(2);
      queue.push(3);

      expect(queue.isEmpty, false);

      expect(queue.peek(), 1);
      expect(queue.pop(), 1);
      expect(queue.pop(), 2);

      queue.push(4);

      expect(queue.pop(), 3);
      expect(queue.pop(), 4);

      expect(queue.isEmpty, true);
    });
  });
}
