import 'package:app_gastos/models/transaction.dart';
import 'package:app_gastos/providers/transaction_provider.dart';

import 'package:app_gastos/screens/transaction_history_screen.dart';

import 'package:app_gastos/widgets/expense_chart.dart';

import 'package:app_gastos/routes/app_routes.dart';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SummaryScreen extends StatefulWidget {
  const SummaryScreen({super.key});

  @override
  State<SummaryScreen> createState() => _SummaryScreenState();
}

class _SummaryScreenState extends State<SummaryScreen> {
  @override
  void initState() {
    super.initState();
    Future.microtask(
      () => context.read<TransactionProvider>().loadTransactions(),
    );
  }
  

  @override
  Widget build(BuildContext context) {
    //final transactionProvider = Provider.of<TransactionProvider>(context);
    final transactions = context.watch<TransactionProvider>().transactions;

    final totalIncome = transactions
        .where((transaction) => transaction.type == TransactionType.income)
        .fold(0.0, (sum, transaction) => sum + transaction.amount);

    final totalExpense = transactions
        .where((transaction) => transaction.type == TransactionType.expense)
        .fold(0.0, (sum, transaction) => sum + transaction.amount);

    // Ejercicio 6
    return WillPopScope(
      onWillPop: () async {
        final exit = await showDialog<bool>(
          context: context,
          builder: (context) => AlertDialog(
            title: Text('Salir'),
            content: Text('¿Desea salir de la aplicación?'),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context, false),
                child: Text('Cancelar'),
              ),
              TextButton(
                onPressed: () => Navigator.pop(context, true),
                child: Text('Salir'),
              ),
            ],
          ),
        );
        return exit ?? false;
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text('Resumen de Gastos'),
          centerTitle: true,
          actions: [
            IconButton(
              onPressed:(){
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (expenseData) => TransactionHistoryScreen()
                  ),
                );
              },
              icon: Icon(Icons.history),
            ),
          ],

        ),

        body: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Resumen del mes',
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold
                  ),
                ),

                SizedBox(height: 20),

                Card(
                  child: ListTile(
                    leading: Icon(Icons.arrow_upward_outlined, color: Colors.green),
                    title: Text('Ingresos'),
                    subtitle: Text('\$${totalIncome.toStringAsFixed(2)}'),
                  ),
                ),

                SizedBox(height: 20),

                Card(
                  child: ListTile(
                    leading: Icon(Icons.arrow_downward_outlined, color: Colors.red),
                    title: Text('Gastos'),
                    subtitle:  Text('\$${totalExpense.toStringAsFixed(2)}'),
                  ),
                ),

                SizedBox(height: 20),

                // Ejercicio 5
                AnimatedOpacity(
                  duration: Duration(milliseconds: 500),
                  opacity: transactions.isEmpty ? 0 : 1,
                  child: ExpenseChart(),
                ),

                SizedBox(height: 20),

                Center(
                  child: ElevatedButton.icon(
                    onPressed: (){
                      
                      /*
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => TransactionFormScreen()
                        ), // materialpageroute
                      );
                      */ 


                      Navigator.pushNamed(context, AppRoutes.addTransaction);


                    }, 
                    icon: Icon(Icons.add),
                    label: Text(
                      'Añadir transaccion',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                  ), 

                ), 

              ], 
            ),

          ), 
        ),
      )
    );
  }
}
