import 'package:app_gastos/routes/app_routes.dart';
import 'package:flutter/material.dart';

import 'package:app_gastos/models/transaction.dart';
import 'package:app_gastos/providers/transaction_provider.dart';

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
      ),


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
              ),
              
              title: Text(transaction.category),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(DateFormat('dd/MM/yyyy').format(transaction.date)), // Ejercicio 1
                  Text(
                    transaction.description, 
                    style: TextStyle(fontStyle: FontStyle.italic, fontSize: 12),
                  ),
                ],
              ),

              trailing: Text(
                '\$${transaction.amount.toStringAsFixed(2)}',
                style: TextStyle(
                  color: transaction.type == TransactionType.income ? Colors.green : Colors.red,
                  fontWeight: FontWeight.bold,
                ),
              ),

              onTap:(){  // Ejercicio 3
                Navigator.pushNamed(
                  context,
                  AppRoutes.addTransaction,
                  arguments: transaction, 
                );  
              },

              onLongPress: () async {  // Ejercicio 2
                final confirmacion = await showDialog<bool>(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      title: Text('Eliminar Transacción'),
                      content: Text('¿Estás seguro de que deseas eliminar este registro?'),
                      actions: [
                        TextButton(
                          onPressed: () => Navigator.pop(context, false),
                          child: Text('Cancelar'),
                        ),
                        TextButton(
                          onPressed: () => Navigator.pop(context, true),
                          child: Text('Eliminar', style: TextStyle(color: Colors.red)),
                        ),
                      ],
                    );
                  },
                );

                if (confirmacion == true) {
                  context.read<TransactionProvider>().deleteTransaction(transaction.id);
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Transacción eliminada')),
                  );
                }
              },

            ),

          );

        },
      
      ));
 }
}
