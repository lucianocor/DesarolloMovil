import 'package:flutter/material.dart';

import 'package:provider/provider.dart';
import 'package:app_todolist/models/task.dart';
import 'package:app_todolist/providers/task_provider.dart';

class TaskFormScreen extends StatefulWidget {
  Task? task;

  TaskFormScreen({super.key, this.task});

  @override
  State<TaskFormScreen> createState() => _TaskFormScreenState();
}


class _TaskFormScreenState extends State<TaskFormScreen>{
  late TextEditingController _titleController;
  late TextEditingController _categoryController; 

  final _formKey = GlobalKey<FormState>();

  bool _isEditing = false;

  @override
  void initState(){
    super.initState();

    if (widget.task!=null){
      _isEditing = true;
      _titleController = TextEditingController(text: widget.task!.title);
      _categoryController = TextEditingController(text:widget.task!.category);
    } else {
      _titleController = TextEditingController();
      _categoryController = TextEditingController();
    }
  }

  @override
  void dispose(){
    _titleController.dispose();
    _categoryController.dispose();
    super.dispose();
  }


  @override
  Widget build(BuildContext context){
    //final taskProvider = Provider.of<TaskProvider>(context, listen:false);

    return Scaffold(
      appBar: AppBar(
        title: Text(
          _isEditing ? 'Editar tarea': 'Añadir tarea',
        ),
      ),

      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                TextFormField(
                  controller: _titleController,
                  decoration: InputDecoration(
                    labelText: 'Título',
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Ingrese un título';
                    }
                    return null;
                  },
                ),

                SizedBox(height: 16),

                TextFormField(
                  controller: _categoryController,
                  decoration: InputDecoration(
                    labelText: 'Categoría',
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Ingrese una categoría';
                    }
                    return null;
                  },
                ),

                SizedBox(height: 24),

                ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      if (_isEditing) {
                        /*
                        taskProvider.editTask(
                          widget.task!.id,
                          _titleController.text,
                          _categoryController.text,
                        );
                        */

                        context.read<TaskProvider>().editTask(
                          widget.task!.id,
                          _titleController.text,
                          _categoryController.text,
                        );

                      } else {
                        /*
                        taskProvider.addTask(
                          _titleController.text,
                          _categoryController.text,
                        );
                        */

                        context.read<TaskProvider>().addTask(                          
                          _titleController.text,
                          _categoryController.text,
                        );

                      }

                      Navigator.pop(context);

                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(
                            _isEditing ? 'Tarea actualizada' : 'Tarea creada',
                          ),
                        ),
                      );
                    }
                  },
                  child: Text(_isEditing ? 'Guardar cambios' : 'Añadir tarea'),
                ),
              ],
            ),
          ),
        ),
      ),






    ); // scaffold
  }

}
