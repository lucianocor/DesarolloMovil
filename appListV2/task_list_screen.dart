import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:app_todolist/providers/task_provider.dart';
import 'package:app_todolist/screens/task_form_screen.dart';
import 'package:app_todolist/routes/app_routes.dart';

import 'package:app_todolist/widgets/filter_buton.dart';
import 'package:app_todolist/widgets/task_item.dart';


class TaskListScreen extends StatelessWidget{
  TaskListScreen({super.key});

  @override
  Widget build(BuildContext context){
    // final taskProvider = Provider.of<TaskProvider>(context);
    final tasks = context.watch<TaskProvider>().tasks;
    final filter = context.watch<TaskProvider>().filter;
    // mejoras en provider


    return Scaffold(
      appBar: AppBar(
        title: Text('Lista de tareas',)
      ), //appbar

      body: Column(
        children: [
          
          Padding(
            padding: EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  child: FilterButton(
                    label: 'Todas',
                    //isSelected: taskProvider.filter == TaskFilter.all,
                    //onPressed: () => taskProvider.setFilter(TaskFilter.all),
                    
                    isSelected: filter == TaskFilter.all,
                    onPressed: () => context.read<TaskProvider>().setFilter(TaskFilter.all),
                  ),
                ),
                SizedBox(width: 8),
                Expanded(
                  child: FilterButton(
                    label: 'Completadas',
                    //isSelected: taskProvider.filter == TaskFilter.completed,
                    //onPressed: () => taskProvider.setFilter(TaskFilter.completed),
                    isSelected: filter == TaskFilter.completed,
                    onPressed: () => context.read<TaskProvider>().setFilter(TaskFilter.completed),
                  ),
                ),
                SizedBox(width: 8),
                Expanded(
                  child: FilterButton(
                    label: 'Pendientes',
                    //isSelected: taskProvider.filter == TaskFilter.pending,
                    //onPressed: () => taskProvider.setFilter(TaskFilter.pending),
                    isSelected: filter == TaskFilter.pending,
                    onPressed: () => context.read<TaskProvider>().setFilter(TaskFilter.pending),
                  ),
                ),
              ],
            ),
          ),


          Expanded (
            child: ListView.builder(
              //itemCount: taskProvider.tasks.length,
              itemCount: tasks.length,

              itemBuilder: (context, index) {
                //final task = taskProvider.tasks[index];
                final task = tasks[index];
                
                //return TaskItem(task: task);

                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context, MaterialPageRoute(
                        builder: (context) => TaskFormScreen(task: task,)
                    ));
                  },

                  child: TaskItem(task:task),

                ); // gestureDetector


              },
            ),
          ), // expanded

        ], // children
      ), // column

      floatingActionButton: FloatingActionButton(
        onPressed: (){
          // Navigator.pushNamed(context, '/add-task');
          Navigator.pushNamed(context, AppRoutes.addTask);

        },
        child: Icon(Icons.add),
      ), // floatingactionbutton
    );
  }

}
