import 'package:flutter/material.dart';

import 'package:app_ing_egr/models/transaction.dart';
import 'package:app_ing_egr/providers/transaction_provider.dart';
import 'package:app_ing_egr/screens/transaction_form_screen.dart';

import 'package:provider/provider.dart';
import 'package:intl/intl.dart';



class TransactionHistoryScreen extends StatelessWidget {
  
  const TransactionHistoryScreen({super.key});

   @override
  Widget build(BuildContext context) {
    final transactionProvider = Provider.of<TransactionProvider>(context);
    final transactions = transactionProvider.transactions;

    return Scaffold(
      appBar: AppBar(
        title: Text('Historial de transacciones'),
        centerTitle: true,
      ), // appbar


      body: transactions.isEmpty ? Center(child: Text('No hay transacciones registradas'))
      : ListView.builder(
        itemCount: transactions.length,
        itemBuilder: (context, index) {
          final transaction = transactions[index];
          return Card(
            margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
            child: ListTile(
              leading: Icon(
                transaction.type == TransactionType.income ? Icons.arrow_upward_outlined : Icons.arrow_downward_outlined,
                color: transaction.type == TransactionType.income ? Colors.green : Colors.red,
              ), // icon
              
              title: Text(transaction.category),
              subtitle: Text(
                DateFormat('yMMd').format(transaction.date),

              ), // text

              trailing: Text(
                '\$${transaction.amount.toStringAsFixed(2)}',
                style: TextStyle(
                  color: transaction.type == TransactionType.income ? Colors.green : Colors.red,
                  fontWeight: FontWeight.bold,
                ), // textstyle
              ), // text

              onTap:(){
                Navigator.push(context, MaterialPageRoute(
                  builder: (context) => TransactionFormScreen(
                    transaction: transaction
                    
                  )
                )); // 
              },

              onLongPress: () {
                transactionProvider.deleteTransaction(transaction.id);
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('transaction eliminada')
                  )
                ); // scaffoldmessenger

              }, // onlongpress

            ), // listtile

          ); // card

        }, // itembuilder
      
      )); // scaffold
 }
}
