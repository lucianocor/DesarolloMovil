import 'package:flutter/material.dart';

import 'package:app_ing_egr/theme/app_theme.dart';
import 'package:app_ing_egr/providers/transaction_provider.dart';
import 'package:app_ing_egr/models/transaction.dart';

import 'package:uuid/uuid.dart';
import 'package:provider/provider.dart';


class TransactionFormScreen extends StatefulWidget{
  final Transaction? transaction; 

  TransactionFormScreen({super.key, this.transaction});

  @override
  State<TransactionFormScreen> createState() => _TransactionFormScreenState();
}

class _TransactionFormScreenState extends State<TransactionFormScreen>{
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _amountController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();

  String _selectedCategory = 'Comida';
  TransactionType _selectedType = TransactionType.expense;


  final List<String> _categories = [
    'Comida',
    'Transporte',
    'Entretenimiento',
    'Trabajo',
    'Otros'
  ];

  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        title: Text('Registrar transaccion'),
      ), // appbar

      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextFormField(
                  controller: _amountController,
                  decoration: InputDecoration(labelText: 'Monto'),
                  keyboardType: TextInputType.number,
                  validator: (value){
                    if (value == null || value.isEmpty){
                      return 'Por favor ingrese un monto';
                    }

                    return null;
                  },
                ), // textformfield

                SizedBox(height: 20),


                TextFormField(
                  controller: _descriptionController,
                  decoration: InputDecoration(labelText: 'Descripcion'),                
                  validator: (value){
                    if (value == null || value.isEmpty){
                      return 'Por favor ingrese una descripcion';
                    }

                    return null;
                  },
                ), // textformfield

                SizedBox(height: 20),

                DropdownButtonFormField(
                  value: _selectedCategory,
                  decoration: InputDecoration(
                    labelText: 'Categoria',
                  ),  
                  items: _categories.map((category){
                    return DropdownMenuItem(
                      value: category,
                      child: Text(category)
                    );
                  }).toList(),
                  onChanged: (value){
                    setState((){
                      _selectedCategory = value!;

                    });
                  },
                ), // dropdown


                SizedBox(height: 20),

                

                /*
                Row(
                  children: [
                    Expanded(
                      child: RadioListTile(
                        title: Text('Gasto'),
                        value: TransactionType.expense,
                        groupValue: _selectedType,
                        onChanged: (TransactionType? value){
                          setState((){
                            _selectedType = value!;
                          }); // setstate
                        },
                      ), // radiolisttile
                    ), // expanded

                    SizedBox(height: 20),

                    Expanded(
                      child: RadioListTile(
                        title: Text('Ingreso'),
                        value: TransactionType.income,
                        groupValue: _selectedType,
                        onChanged: (TransactionType? value){
                          setState((){
                            _selectedType = value!;
                          }); // setstate
                        },
                      ), // radiolisttile
                    ), // expanded


                  ], // children
                ),
                */



                Row(
                  children: [
                    Expanded(
                      child: RadioListTile(
                        title: const Text('Gasto'),
                        value: TransactionType.expense,
                        groupValue: _selectedType,
                        onChanged: (value) {
                          setState(() => _selectedType = value!);
                        },
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: RadioListTile(
                        title: const Text('Ingreso'),
                        value: TransactionType.income,
                        groupValue: _selectedType,
                        onChanged: (value) {
                          setState(() => _selectedType = value!);
                        },
                      ),
                    ),
                  ],
                ),


                SizedBox(height: 20),

                Center(
                  child: 


                      ElevatedButton(
                        onPressed: () async {
                          if (_formKey.currentState!.validate()) {

                            final provider = context.read<TransactionProvider>();

                            if (widget.transaction == null) {

                              await provider.addTransaction(
                                Transaction(
                                  id: Uuid().v4(),
                                  category: _selectedCategory,
                                  amount: double.parse(_amountController.text),
                                  type: _selectedType,
                                  date: DateTime.now(),
                                ),
                              );

                            } else {

                              await provider.updateTransaction(
                                Transaction(
                                  id: widget.transaction!.id,
                                  category: _selectedCategory,
                                  amount: double.parse(_amountController.text),
                                  type: _selectedType,
                                  date: widget.transaction!.date,
                                ),
                              );

                            }

                            if (!mounted) return;

                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text(
                                  widget.transaction == null
                                      ? 'Transacción registrada'
                                      : 'Transacción editada',
                                ),
                                duration: Duration(seconds: 1),
                              ),
                            );

                            // Esperar un momento para que se muestre el SnackBar
                            await Future.delayed(Duration(milliseconds: 300));

                            if (mounted) {
                              Navigator.pop(context);
                            }
                          }
                        },
                        child: Text(
                          widget.transaction == null
                              ? 'Añadir Transacción'
                              : 'Editar Transacción',
                        ),
                      )



                ), // center

              ], // children
            ), // column

          ), // form
        ),
   ), // singlechildScrollview


    ); // scaffold
  }
}
