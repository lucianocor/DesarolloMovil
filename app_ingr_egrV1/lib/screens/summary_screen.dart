import 'package:flutter/material.dart';

import 'transaction_form_screen.dart';




class SummaryScreen extends StatelessWidget {
  const SummaryScreen({super.key});

  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Resumen de Gastos'),
        centerTitle: true,
      ), // appBar

      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Resumen del mes',
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold
              ), // textstyle
            ), // text

            SizedBox(height: 20),

            Card(
              child: ListTile(
                leading: Icon(Icons.arrow_upward_outlined, color: Colors.green),
                title: Text('Ingresos'),
                subtitle: Text('\50.0'),
              ), // listtile
            ),

            SizedBox(height: 20),

            Card(
              child: ListTile(
                leading: Icon(Icons.arrow_downward_outlined, color: Colors.red),
                title: Text('Gastos'),
                subtitle: Text('\50.0'),
              ), // listtile
            ),

            SizedBox(height: 20),

            Center(
              child: ElevatedButton.icon(
                onPressed: (){
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => TransactionFormScreen()
                    ), // materialpageroute
                  ); 
                }, 
                icon: Icon(Icons.add),
                label: Text('Añadir transaccion'),
              ), // elevatedButton

            ), // center

          ], // children
        ), // column
      ), // padding

    ); // scaffold
  }
}
