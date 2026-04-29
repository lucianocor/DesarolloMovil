import 'package:flutter/material.dart';
import 'package:app_ing_egr/models/transaction.dart';
import 'package:app_ing_egr/services/database_helper.dart';


class TransactionProvider with ChangeNotifier{
  
  List<Transaction> _transactions = [];
  final DatabaseHelper _dbHelper = DatabaseHelper();
  bool _isLoading = true;

  List<Transaction> get transactions => _transactions;
  bool get isLoading => _isLoading;


  Future<void> loadTransactions() async {
    _isLoading = true;
    notifyListeners();
    
    _transactions = await _dbHelper.getTransactions();
    
    _isLoading = false;
    notifyListeners();
  }


  /*
  void addTransaction(Transaction transaction) async {
    _transactions.add(transaction);
    await _dbHelper.insertTransaction(transaction);
    notifyListeners();
  }
  */


 /*
  void updateTransaction(Transaction transaction) async {
    int index = _transactions.indexWhere((t) => t.id == transaction.id);
    _transactions[index] = transaction;

    await _dbHelper.updateTransaction(transaction);
    notifyListeners();

  }
  */


  
  void deleteTransaction(String id) async {
    _transactions.removeWhere((transaction) => transaction.id == id);
    await _dbHelper.deleteTransaction(id);
    notifyListeners();
  }

 

  Future<void> addTransaction(Transaction transaction) async {
    _transactions.add(transaction);
    await _dbHelper.insertTransaction(transaction);
    notifyListeners();
  }

  Future<void> updateTransaction(Transaction transaction) async {
    int index = _transactions.indexWhere((t) => t.id == transaction.id);
    _transactions[index] = transaction;

    await _dbHelper.updateTransaction(transaction);
    notifyListeners();
  }  

    
}
