import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

import '../providers/todo_provider.dart';
import 'add_todo_screen.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final todos = ref.watch(todoProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('Todo List'), centerTitle: true),
      body: ListView.builder(
        itemCount: todos.length,
        itemBuilder: (context, index) {
          final todo = todos[index];
          return Dismissible(
            key: Key(todo.id),
            background: Container(
              color: Colors.red,
              alignment: Alignment.centerRight,
              padding: const EdgeInsets.only(right: 20),
              child: const Icon(Icons.delete, color: Colors.white),
            ),
            direction: DismissDirection.endToStart,
            onDismissed: (direction) {
              ref.read(todoProvider.notifier).deleteTodo(todo.id);
            },
            child: Card(
              margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: ListTile(
                leading: Checkbox(
                  value: todo.isCompleted,
                  onChanged: (value) {
                    ref.read(todoProvider.notifier).toggleTodo(todo.id);
                  },
                ),
                title: Text(
                  todo.title,
                  style: TextStyle(
                    decoration:
                        todo.isCompleted ? TextDecoration.lineThrough : null,
                  ),
                ),
                subtitle: todo.dueTime != null
                    ? Text(
                        DateFormat(
                          'MMM dd, yyyy - hh:mm a',
                        ).format(todo.dueTime!),
                        style: const TextStyle(color: Colors.grey),
                      )
                    : null,
                trailing: IconButton(
                  icon: const Icon(Icons.edit),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => AddTodoScreen(todo: todo),
                      ),
                    );
                  },
                ),
              ),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const AddTodoScreen()),
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
