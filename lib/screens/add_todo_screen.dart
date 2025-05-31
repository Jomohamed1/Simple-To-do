import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/todo_item.dart';
import '../providers/todo_provider.dart';

class AddTodoScreen extends ConsumerStatefulWidget {
  final TodoItem? todo;

  const AddTodoScreen({super.key, this.todo});

  @override
  ConsumerState<AddTodoScreen> createState() => _AddTodoScreenState();
}

class _AddTodoScreenState extends ConsumerState<AddTodoScreen> {
  late TextEditingController _titleController;
  DateTime? _selectedTime;

  @override
  void initState() {
    super.initState();
    _titleController = TextEditingController(text: widget.todo?.title);
    _selectedTime = widget.todo?.dueTime;
  }

  @override
  void dispose() {
    _titleController.dispose();
    super.dispose();
  }

  Future<void> _selectTime() async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedTime ?? DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2100),
    );

    if (picked != null) {
      final TimeOfDay? time = await showTimePicker(
        // ignore: use_build_context_synchronously
        context: context,
        initialTime: TimeOfDay.now(),
      );

      if (time != null) {
        setState(() {
          _selectedTime = DateTime(
            picked.year,
            picked.month,
            picked.day,
            time.hour,
            time.minute,
          );
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.todo == null ? 'Add Todo' : 'Edit Todo'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _titleController,
              decoration: const InputDecoration(
                labelText: 'Todo Title',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),
            ListTile(
              title: const Text('Due Time'),
              subtitle: Text(
                _selectedTime != null
                    ? '${_selectedTime!.day}/${_selectedTime!.month}/${_selectedTime!.year} - ${_selectedTime!.hour}:${_selectedTime!.minute}'
                    : 'No time selected',
              ),
              trailing: IconButton(
                icon: const Icon(Icons.calendar_today),
                onPressed: _selectTime,
              ),
            ),
            const Spacer(),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  if (_titleController.text.isNotEmpty) {
                    if (widget.todo == null) {
                      ref
                          .read(todoProvider.notifier)
                          .addTodo(_titleController.text, _selectedTime);
                    } else {
                      ref
                          .read(todoProvider.notifier)
                          .updateTodo(
                            widget.todo!.id,
                            _titleController.text,
                            _selectedTime,
                          );
                    }
                    Navigator.pop(context);
                  }
                },
                child: Text(widget.todo == null ? 'Add Todo' : 'Update Todo'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
