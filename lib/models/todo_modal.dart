// lib/models/todo_modal.dart
class TodoModal {
  final int id;
  final String title;
  final String description;
  final bool completed;
  final String date;

  TodoModal({
    required this.id,
    required this.title,
    required this.description,
    required this.completed,
    required this.date,
  });

  // Convert to JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'completed': completed,
      'date': date,
    };
  }

  // Create from JSON
  factory TodoModal.fromJson(Map<String, dynamic> json) {
    return TodoModal(
      id: json['id'],
      title: json['title'],
      description: json['description'],
      completed: json['completed'],
      date: json['date'],
    );
  }
}
