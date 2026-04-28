import 'package:flutter/material.dart';


import 'package:provider/provider.dart';

import 'providers/transaction_provider.dart';
import 'routes/app_routes.dart';
import 'theme/app_theme.dart';



void main() => runApp(
  MultiProvider(
    providers:[
      ChangeNotifierProvider(create: (_) => TransactionProvider())
    ],
    child: MyApp(),  
  ) // multiprovider
); 


class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    
    /*
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      home: Scaffold(
        body: SummaryScreen(),
      ), // scaffold
    ); // materialApp
    */


    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      initialRoute: AppRoutes.home,
      routes: AppRoutes.routes,
    );


  }
}