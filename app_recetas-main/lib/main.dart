import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:app_recetas/screens/recipe_list_screen.dart';
import 'package:app_recetas/providers/recipe_provider.dart';



void main() => runApp(
  MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (_) => RecipeProvider())
    ],

    child: MyApp(),
  )

);fl    


class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Aplicacion de Recetas',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),

      home: RecipeListScreen()
    );
  }
}
