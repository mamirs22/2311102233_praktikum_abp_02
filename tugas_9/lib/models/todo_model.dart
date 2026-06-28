// Model data untuk satu item To-Do
class TodoModel {
  final String id;
  final String title;
  bool isDone;
  final DateTime createdAt;

  TodoModel({
    required this.id,
    required this.title,
    this.isDone = false,
    required this.createdAt,
  });
}
