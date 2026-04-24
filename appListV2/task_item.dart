import 'package:flutter/material.dart';
import 'package:app_todolist/models/task.dart';
import 'package:app_todolist/providers/task_provider.dart';
import 'package:provider/provider.dart';

class TaskItem extends StatelessWidget{
  final Task task;

  TaskItem({super.key, required this.task});

  @override
  Widget build(BuildContext context){ 
    // final taskProvider = Provider.of<TaskProvider>(context, listen:false);
    final taskProvider = context.read<TaskProvider>();

    return Card(
      child: ListTile(
        title: Text(
           task.title,
           style: TextStyle(
            decoration: task.isCompleted ? TextDecoration.lineThrough: null
           ), // textstyle
        ), // text

        trailing: Checkbox(
          value: task.isCompleted,
          onChanged: (value){
            taskProvider.toggleTaskStatus(task.id);
          },
        ), // checkbox

      ), // listtile
    );   // card 
  }

}

