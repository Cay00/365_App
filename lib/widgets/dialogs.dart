import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';
import '../models/todo_task.dart';
import '../providers/todo_provider.dart';

void showAddTaskDialog(BuildContext context, String selectedList) {
  final TextEditingController taskController = TextEditingController();
  DateTime? selectedDate;

  showDialog(
    context: context,
    builder: (context) => StatefulBuilder(
      builder: (context, setState) => AlertDialog(
        title: const Text('Dodaj zadanie'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: taskController,
              autofocus: true,
              decoration: const InputDecoration(
                hintText: 'Nazwa zadania',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 15),
            Row(
              children: [
                IconButton(
                  icon: const Icon(Icons.calendar_today),
                  onPressed: () async {
                    final date = await showDatePicker(
                      context: context,
                      initialDate: DateTime.now(),
                      firstDate: DateTime(2000),
                      lastDate: DateTime(2100),
                    );
                    if (date != null) {
                      setState(() => selectedDate = date);
                    }
                  },
                ),
                Text(
                  selectedDate != null
                      ? DateFormat('dd.MM.yyyy').format(selectedDate!)
                      : 'Brak terminu',
                  style: TextStyle(
                    color: selectedDate != null ? Colors.white : Colors.grey,
                  ),
                ),
              ],
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Anuluj'),
          ),
          TextButton(
            onPressed: () {
              if (taskController.text.isNotEmpty) {
                Provider.of<TodoProvider>(context, listen: false).addTask(
                  taskController.text,
                  selectedList,
                  dueDate: selectedDate,
                );
              }
              Navigator.pop(context);
            },
            child: const Text('Dodaj'),
          ),
        ],
      ),
    ),
  );
}

void showEditTaskDialog(BuildContext context, Todo task) {
  final TextEditingController taskController = TextEditingController(text: task.title);
  DateTime? selectedDate = task.dueDate;

  showDialog(
    context: context,
    builder: (context) => StatefulBuilder(
      builder: (context, setState) => AlertDialog(
        title: const Text('Edytuj zadanie'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: taskController,
              autofocus: true,
              decoration: const InputDecoration(
                hintText: 'Edytuj nazwę zadania',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 15),
            Row(
              children: [
                IconButton(
                  icon: const Icon(Icons.calendar_today),
                  onPressed: () async {
                    final date = await showDatePicker(
                      context: context,
                      initialDate: selectedDate ?? DateTime.now(),
                      firstDate: DateTime(2000),
                      lastDate: DateTime(2100),
                    );
                    if (date != null) {
                      setState(() => selectedDate = date);
                    }
                  },
                ),
                Text(
                  selectedDate != null
                      ? DateFormat('dd.MM.yyyy').format(selectedDate!)
                      : 'Brak terminu',
                  style: TextStyle(
                    color: selectedDate != null ? Colors.white : Colors.grey,
                  ),
                ),
                if (selectedDate != null)
                  IconButton(
                    icon: const Icon(Icons.clear),
                    onPressed: () => setState(() => selectedDate = null),
                  ),
              ],
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Anuluj'),
          ),
          TextButton(
            onPressed: () {
              if (taskController.text.isNotEmpty) {
                Provider.of<TodoProvider>(context, listen: false).editTask(
                  task.id,
                  taskController.text,
                  dueDate: selectedDate,
                );
              }
              Navigator.pop(context);
            },
            child: const Text('Zapisz'),
          ),
        ],
      ),
    ),
  );
}

void showAddListDialog(BuildContext context) {
  final TextEditingController listController = TextEditingController();
  showDialog(
    context: context,
    builder: (context) => AlertDialog(
      title: const Text('Dodaj nową listę'),
      content: TextField(
        controller: listController,
        autofocus: true,
        decoration: const InputDecoration(
          hintText: 'Nazwa listy',
          border: OutlineInputBorder(),
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text('Anuluj'),
        ),
        TextButton(
          onPressed: () {
            if (listController.text.isNotEmpty) {
              Provider.of<TodoProvider>(context, listen: false)
                  .addList(listController.text);
            }
            Navigator.pop(context);
          },
          child: const Text('Dodaj'),
        ),
      ],
    ),
  );
}

void showDeleteConfirmationDialog(BuildContext context, String taskId) {
  showDialog(
    context: context,
    builder: (context) => AlertDialog(
      title: const Text('Usunąć zadanie?'),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text('Anuluj'),
        ),
        TextButton(
          onPressed: () {
            Provider.of<TodoProvider>(context, listen: false)
                .removeTask(taskId);
            Navigator.pop(context);
          },
          child: const Text('Usuń', style: TextStyle(color: Colors.red)),
        ),
      ],
    ),
  );
}