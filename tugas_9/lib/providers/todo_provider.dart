import 'package:flutter/material.dart';
import '../models/todo_model.dart';

// Provider untuk mengelola state daftar tugas (To-Do List)
class TodoProvider extends ChangeNotifier {
  final List<TodoModel> _todos = [];

  // Getter: list todo yang tidak bisa dimodifikasi dari luar
  List<TodoModel> get todos => List.unmodifiable(_todos);

  // Getter: jumlah tugas yang belum selesai
  int get pendingCount => _todos.where((t) => !t.isDone).length;

  // Getter: jumlah tugas yang sudah selesai
  int get doneCount => _todos.where((t) => t.isDone).length;

  // Tambah tugas baru
  void addTodo(String title) {
    if (title.trim().isEmpty) return;
    _todos.add(
      TodoModel(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        title: title.trim(),
        createdAt: DateTime.now(),
      ),
    );
    notifyListeners(); // Beritahu semua widget yang mendengarkan
  }

  // Toggle status selesai/belum selesai
  void toggleTodo(String id) {
    final index = _todos.indexWhere((t) => t.id == id);
    if (index != -1) {
      _todos[index].isDone = !_todos[index].isDone;
      notifyListeners();
    }
  }

  // Hapus satu tugas berdasarkan ID
  void removeTodo(String id) {
    _todos.removeWhere((t) => t.id == id);
    notifyListeners();
  }

  // Hapus semua tugas sekaligus
  void clearAll() {
    _todos.clear();
    notifyListeners();
  }

  // Hapus hanya tugas yang sudah selesai
  void clearDone() {
    _todos.removeWhere((t) => t.isDone);
    notifyListeners();
  }
}
