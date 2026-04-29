import 'package:flutter/material.dart';
import 'package:app_ing_egr/screens/summary_screen.dart';
import 'package:app_ing_egr/screens/transaction_form_screen.dart';
import 'package:app_ing_egr/screens/transaction_history_screen.dart';

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