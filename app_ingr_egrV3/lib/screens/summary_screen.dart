import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/transaction.dart';
import '../providers/transaction_provider.dart';
import '../routes/app_routes.dart';
import '../widgets/expense_chart.dart';
import 'transaction_history_screen.dart';

class SummaryScreen extends StatefulWidget {
  const SummaryScreen({super.key});

  @override
  State<SummaryScreen> createState() => _SummaryScreenState();
}

class _SummaryScreenState extends State<SummaryScreen> {
  @override
  void initState() {
    super.initState();
    //Provider.of<TransactionProvider>(context, listen: false).loadTransactions();

    @override
    void initState() {
      super.initState();
      Future.microtask(
        () => context.read<TransactionProvider>().loadTransactions(),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    //final transactionProvider = Provider.of<TransactionProvider>(context);
    //final transactions = context.watch<TransactionProvider>().transactions;

    final transactions = context.watch<TransactionProvider>().transactions;

    final totalIncome = transactions
        .where((transaction) => transaction.type == TransactionType.income)
        .fold(0.0, (sum, transaction) => sum + transaction.amount);

    final totalExpense = transactions
        .where((transaction) => transaction.type == TransactionType.expense)
        .fold(0.0, (sum, transaction) => sum + transaction!.amount);

    return Scaffold(
      appBar: AppBar(
        title: Text('Resumen de Gastos'),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (expenseData) => TransactionHistoryScreen(),
                ),
              );
            },
            icon: Icon(Icons.history),
          ), // iconbutton
        ], // actions
      ), // appBar

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
                  fontWeight: FontWeight.bold,
                ), // textstyle
              ), // text

              SizedBox(height: 20),

              Card(
                child: ListTile(
                  leading: Icon(
                    Icons.arrow_upward_outlined,
                    color: Colors.green,
                  ),
                  title: Text('Ingresos'),
                  subtitle: Text('\$${totalIncome.toStringAsFixed(2)}'),
                ), // listtile
              ),

              SizedBox(height: 20),

              Card(
                child: ListTile(
                  leading: Icon(
                    Icons.arrow_downward_outlined,
                    color: Colors.red,
                  ),
                  title: Text('Gastos'),
                  subtitle: Text('\$${totalExpense.toStringAsFixed(2)}'),
                ), // listtile
              ),

              SizedBox(height: 20),

              ExpenseChart(), // el widget (grafico)

              SizedBox(height: 20),

              Center(
                child: ElevatedButton.icon(
                  onPressed: () {
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
                ), // elevatedButton
              ), // center
            ], // children
          ), // column
        ), // padding
      ), // SingleChildScrollView
    ); // scaffold
  }
}
