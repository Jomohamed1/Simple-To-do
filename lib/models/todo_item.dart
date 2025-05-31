class TodoItem {
  final String id;
  final String title;
  final DateTime? dueTime;
  final bool isCompleted;

  TodoItem({
    required this.id,
    required this.title,
    this.dueTime,
    this.isCompleted = false,
  });

  TodoItem copyWith({
    String? id,
    String? title,
    DateTime? dueTime,
    bool? isCompleted,
  }) {
    return TodoItem(
      id: id ?? this.id,
      title: title ?? this.title,
      dueTime: dueTime ?? this.dueTime,
      isCompleted: isCompleted ?? this.isCompleted,
    );
  }
}
