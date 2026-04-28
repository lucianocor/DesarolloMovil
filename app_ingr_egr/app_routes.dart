import 'package:flutter/material.dart';

import 'summary_screen.dart';
import 'transaction_form_screen.dart';
import 'transaction_history_screen.dart';


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