/*

TO-DO MODEL

This is what a todo object is.

It has these proporties:
- id
- title
- isCompleted
- listName
- dueDate

*/

class Todo {
  final String id;
  String title;
  bool isCompleted;
  String listName;
  DateTime? dueDate;

  Todo({
    required this.id,
    required this.title,
    this.isCompleted = false,
    required this.listName,
    this.dueDate,
  });
}
