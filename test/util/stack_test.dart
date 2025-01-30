import 'package:test/test.dart';
import 'package:tikka/util/stack.dart';

void main() {
  group('Stack', () {
    late Stack<int> stack;

    setUp(() {
      stack = Stack<int>();
    });

    test('isEmpty returns true for empty stack', () {
      expect(stack.isEmpty, isTrue);
    });

    test('isNotEmpty returns false for empty stack', () {
      expect(stack.isNotEmpty, isFalse);
    });

    test('size returns 0 for empty stack', () {
      expect(stack.size, equals(0));
    });

    test('push adds an item to the stack', () {
      stack.push(1);
      expect(stack.isNotEmpty, isTrue);
      expect(stack.size, equals(1));
    });

    test('pop removes and returns the last added item', () {
      stack.push(1);
      stack.push(2);
      expect(stack.pop(), equals(2));
      expect(stack.size, equals(1));
    });

    test('peek returns the last added item without removing it', () {
      stack.push(1);
      stack.push(2);
      expect(stack.peek(), equals(2));
      expect(stack.size, equals(2));
    });

    test('toString returns a string representation of the stack', () {
      stack.push(1);
      stack.push(2);
      expect(stack.toString(), equals('[1, 2]'));
    });

    test('clear removes all items from the stack', () {
      stack.push(1);
      stack.push(2);
      stack.clear();
      expect(stack.isEmpty, isTrue);
      expect(stack.size, equals(0));
    });


    test('pop throws exception when called on empty stack', () {
      stack.clear();
      expect(() => stack.pop(), throwsA(isA<RangeError>()));
    });

    test('peek throws exception when called on empty stack', () {
      stack.clear();
      expect(() => stack.peek(), throwsA(isA<StateError>()));
    });

  });
}

