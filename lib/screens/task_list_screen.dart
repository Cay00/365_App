import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import '../providers/todo_provider.dart';
import '../widgets/dialogs.dart';
import '../assets/theme.dart';


class TaskListScreen extends StatelessWidget {
  final String listName;

  const TaskListScreen({super.key, required this.listName});

  @override
  Widget build(BuildContext context) {
    final todoProvider = Provider.of<TodoProvider>(context);
    final tasks = todoProvider.getTasksByList(listName);

    return Scaffold(
      backgroundColor: AppColors.primary,
      appBar: AppBar(
        title: Text(
          listName,
          style: const TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.black,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: tasks.isEmpty
          ? const Center(child: Text('Brak zadań'))
          : ListView.builder(
              padding: const EdgeInsets.all(8),
              itemCount: tasks.length,
              itemBuilder: (context, index) {
                final task = tasks[index];
                return Dismissible(
                  key: Key(task.id),
                  background: Container(color: Colors.red),
                  confirmDismiss: (_) async {
                    showDeleteConfirmationDialog(context, task.id);
                    return false;
                  },
                  child: ListTile(
                    title: Text(
                      task.title,
                      style: TextStyle(
                        color:
                            task.isCompleted ? Colors.grey[400] : Colors.white,
                        decoration: task.isCompleted
                            ? TextDecoration.lineThrough
                            : null,
                      ),
                    ),
                    subtitle: task.dueDate != null
                        ? Text(
                            'Termin: ${DateFormat('dd.MM.yyyy').format(task.dueDate!)}',
                            style: TextStyle(
                              color: task.dueDate!.isBefore(DateTime.now())
                                  ? Colors.red
                                  : Colors.grey[400],
                            ),
                          )
                        : null,
                    leading: Checkbox(
                      value: task.isCompleted,
                      onChanged: (_) => todoProvider.toggleTask(task.id),
                      fillColor: MaterialStateProperty.resolveWith<Color>(
                        (Set<MaterialState> states) {
                          if (states.contains(MaterialState.selected)) {
                            return Colors.blue;
                          }
                          return Colors.grey[800]!;
                        },
                      ),
                    ),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          icon: const Icon(Icons.delete, color: Colors.red),
                          onPressed: () =>
                              showDeleteConfirmationDialog(context, task.id),
                        ),
                      ],
                    ),
                    onLongPress: () => showEditTaskDialog(context, task),
                  ),
                );
              },
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => showAddTaskDialog(context, listName),
        child: const Icon(Icons.add),
      ),
    );
  }

  void _deleteListWithConfirmation(BuildContext context, String listName) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Usunąć listę?'),
        content: Text('Czy na pewno chcesz usunąć listę "$listName"?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Anuluj'),
          ),
          TextButton(
            onPressed: () {
              Provider.of<TodoProvider>(context, listen: false)
                  .removeList(listName);
              Navigator.pop(context);
              Navigator.pop(context); // Powrót do poprzedniego ekranu
            },
            child: const Text('Usuń', style: TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );
  }
}
