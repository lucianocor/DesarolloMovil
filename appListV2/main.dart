import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:app_todolist/providers/task_provider.dart';
import 'package:app_todolist/screens/task_list_screen.dart';
import 'package:app_todolist/screens/task_form_screen.dart';
import 'package:app_todolist/routes/app_routes.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => TaskProvider()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'ToDo App',

      debugShowCheckedModeBanner: false,

      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.deepPurple,
        ),
        useMaterial3: true,
      ),

      initialRoute: AppRoutes.home,
      routes: AppRoutes.routes,

    );
  }
}

