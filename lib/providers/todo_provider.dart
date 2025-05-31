import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:uuid/uuid.dart';
import '../models/todo_item.dart';

final todoProvider = StateNotifierProvider<TodoNotifier, List<TodoItem>>((ref) {
  return TodoNotifier();
});

class TodoNotifier extends StateNotifier<List<TodoItem>> {
  TodoNotifier() : super([]);

  void addTodo(String title, DateTime? dueTime) {
    final newTodo = TodoItem(
      id: const Uuid().v4(),
      title: title,
      dueTime: dueTime,
    );
    state = [...state, newTodo];
  }

  void toggleTodo(String id) {
    state =
        state.map((todo) {
          if (todo.id == id) {
            return todo.copyWith(isCompleted: !todo.isCompleted);
          }
          return todo;
        }).toList();
  }

  void deleteTodo(String id) {
    state = state.where((todo) => todo.id != id).toList();
  }

  void updateTodo(String id, String newTitle, DateTime? newDueTime) {
    state =
        state.map((todo) {
          if (todo.id == id) {
            return todo.copyWith(title: newTitle, dueTime: newDueTime);
          }
          return todo;
        }).toList();
  }
}
