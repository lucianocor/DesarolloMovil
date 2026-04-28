import 'package:flutter/material.dart';


import '../screens/summary_screen.dart';
import '../screens/transaction_form_screen.dart';
import '../screens/transaction_history_screen.dart';

class AppRoutes {
  static const home = '/';
  static const addTransaction = '/add-transaction';
  static const history = '/history';

  static Map<String, WidgetBuilder> routes = {
    home: (_) => const SummaryScreen(),
    addTransaction: (_) => TransactionFormScreen(),
    history: (_) => const TransactionHistoryScreen(),
  };
}