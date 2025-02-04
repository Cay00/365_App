import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import '../assets/theme.dart';
import 'task_list_screen.dart';
import '../providers/todo_provider.dart';

class TodoScreen extends StatelessWidget {
  const TodoScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: AppColors.primary,
      body: _HomeContent(),
    );
  }
}

class _HomeContent extends StatelessWidget {
  const _HomeContent();

  @override
  Widget build(BuildContext context) {
    final todoProvider = Provider.of<TodoProvider>(context);
    final lists = todoProvider.lists;
    const colorSecond = AppColors.secondary;
    const colorThird = AppColors.tertiary;

    String formattedDate = DateFormat("MMM d").format(DateTime.now());

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Welcome back',
                    style: TextStyle(
                      color: AppColors.secondary,
                      fontSize: 16,
                    ),
                  ),
                  SizedBox(height: 5),
                  Text(
                    'Chris',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                    ),
                  ),
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  const Text(
                    'Today is',
                    style: TextStyle(
                      color: AppColors.secondary,
                      fontSize: 16,
                    ),
                  ),
                  const SizedBox(height: 5),
                  Text(
                    formattedDate,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                    ),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 20),
          Expanded(
            child: ListView.separated(
              separatorBuilder: (context, index) => const SizedBox(height: 20),
              itemCount: lists.length,
              itemBuilder: (context, index) {
                final list = lists[index];
                final taskCount = todoProvider.getTasksByList(list.name).length;
                return _DarkListTile(
                  listName: list.name,
                  taskCount: taskCount,
                  colorSecond: colorSecond,
                  colorThird: colorThird,
                  onTap: () => _navigateToTaskList(context, list.name),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  void _navigateToTaskList(BuildContext context, String listName) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => TaskListScreen(listName: listName),
      ),
    );
  }
}

class _DarkListTile extends StatelessWidget {
  final String listName;
  final int taskCount;
  final Color colorSecond;
  final Color colorThird;
  final VoidCallback onTap;

  const _DarkListTile({
    required this.listName,
    required this.taskCount,
    required this.colorSecond,
    required this.colorThird,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    IconData icon;
    if (listName == 'My Day') {
      icon = Icons.wb_sunny_outlined;
    } else if (listName == 'Important') {
      icon = Icons.star_outline;
    } else if (listName == 'Planned') {
      icon = Icons.calendar_month_outlined;
    } else {
      icon = Icons.folder_open_rounded;
    }

    return Column(
      children: [
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
          ),
          child: ListTile(
            //tileColor: Colors.black,
            title: Row(
              children: [
                Icon(icon, color: Colors.white30),
                const SizedBox(width: 20),
                Text(
                  listName,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                  ),
                ),
              ],
            ),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  '$taskCount',
                  style: const TextStyle(
                    color: AppColors.secondary,
                    fontSize: 16,
                  ),
                ),
                const SizedBox(width: 10),
                const Icon(
                  Icons.arrow_forward_ios,
                  color: AppColors.secondary,
                  size: 12,
                ),
              ],
            ),
            contentPadding:
            const EdgeInsets.symmetric(horizontal: 10, vertical: 0),
            onTap: onTap,
          ),
        ),
        if (listName == 'All')
          const Padding(
            padding: EdgeInsets.only(top: 20),
            child: Divider(
              color: AppColors.tertiary,
              height: 1,
            ),
          ),
      ],
    );
  }
}
