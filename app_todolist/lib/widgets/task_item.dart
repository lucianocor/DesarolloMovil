import 'package:flutter/material.dart';
import 'package:app_todolist/models/task.dart';
import 'package:app_todolist/providers/task_provider.dart';
import 'package:provider/provider.dart';

class TaskItem extends StatelessWidget {
  final Task task;
  final VoidCallback? onTap;

  TaskItem({super.key, required this.task, this.onTap});

  @override
  Widget build(BuildContext context) {
    // final taskProvider = Provider.of<TaskProvider>(context, listen:false);
    final taskProvider = context.read<TaskProvider>();

    return Card(
      child: ListTile(
        onTap: onTap,
        title: Text(
          task.title,
          style: TextStyle(
            decoration: task.isCompleted ? TextDecoration.lineThrough : null,
          ),
        ),

        trailing: Checkbox(
          value: task.isCompleted,
          onChanged: (value) {
            taskProvider.toggleTaskStatus(task.id);
          },
        ),
        onLongPress: () {
          showDialog(
            context: context,
            builder: (context) => AlertDialog(
              title: Text('Eliminar tarea'),
              content: Text('¿Estás seguro?'),
              actions: [
                TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: Text('Cancelar'),
                ),
                TextButton(
                  onPressed: () {
                    context.read<TaskProvider>().deleteTask(task.id);
                    Navigator.pop(context);
                    ScaffoldMessenger.of(
                      context,
                    ).showSnackBar(SnackBar(content: Text('Tarea eliminada')));
                  },
                  child: Text('Eliminar'),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
