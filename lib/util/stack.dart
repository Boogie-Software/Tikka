/// [Stack] implements stack data structure.
class Stack<T> {
  final _items = <T>[];

  /// Checks if the stack is empty
  bool get isEmpty => _items.isEmpty;

  /// Checks if the stack is not empty
  bool get isNotEmpty => _items.isNotEmpty;

  /// Gets the size of the stack
  int get size => _items.length;

  /// Pushes the given [item] into stack 
  void push(T item) => _items.add(item);

  /// Removes the latest pushed item and returns it.
  T pop() => _items.removeLast();

  /// Returns the latest pushed item without removing it.
  T peek() => _items.last;

  @override
  String toString() => _items.toString();

  /// Clear all the items from the stack.
  void clear() {
    _items.clear();
  }
}