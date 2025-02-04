import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../models/todo_task.dart';
import '../models/todo_list.dart';

class TodoProvider extends ChangeNotifier {
  int _taskIdCounter = 0;

  final List<TodoList> _lists = [
    TodoList(name: 'My Day'),
    TodoList(name: 'Important'),
    TodoList(name: 'Planned'),
    TodoList(name: 'All'),
  ];

  final List<Todo> _tasks = []; // Private tasks list

  // Getter – get list
  List<TodoList> get lists => _lists;

  List<Todo> get tasks => _tasks;

  // Get list tasks
  List<Todo> getTasksByList(String listName) {
    if (listName == 'All') {
      return _tasks;
    }
    return _tasks.where((task) => task.listName == listName).toList();
  }

  // Create a new list
  void addList(String name) {
    if (name.trim().isEmpty ||
        name == 'All' ||
        _lists.any((list) => list.name == name)) {
      return;
    }
    _lists.add(TodoList(name: name));
    notifyListeners();
  }

  // Delete list
  void removeList(String listName) {
    if (listName == 'All') return; // Block deletion of default lists
    _lists.removeWhere((list) => list.name == listName);
    // Remove related tasks
    _tasks.removeWhere((task) => task.listName == listName);
    notifyListeners();
  }

  // Add task
  void addTask(String title, String listName, {DateTime? dueDate}) {
    _tasks.add(Todo(
      id: (_taskIdCounter++).toString(),
      title: title,
      listName: listName,
      dueDate: dueDate,
    ));
    notifyListeners();
  }

  // Edit task
  void editTask(String taskId, String newTitle, {DateTime? dueDate}) {
    final task = _tasks.firstWhere((task) => task.id == taskId);
    task.title = newTitle;
    task.dueDate = dueDate;
    notifyListeners();
  }

  // Delete task from list
  void removeTask(String taskId) {
    _tasks.removeWhere((task) => task.id == taskId);
    notifyListeners();
  }

  // Change the status of task (completion)
  void toggleTask(String taskId) {
    final index = _tasks.indexWhere((task) => task.id == taskId);
    if (index != -1) {
      _tasks[index].isCompleted = !_tasks[index].isCompleted;
      notifyListeners();
    }
  }

  // Add date of task completion
  void updateDueDate(String taskId, DateTime newDate) {
    final task = _tasks.firstWhere((t) => t.id == taskId);
    task.dueDate = newDate;
    notifyListeners();
  }
}
