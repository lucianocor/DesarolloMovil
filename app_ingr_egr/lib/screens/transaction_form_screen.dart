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
  
  // Ejercicio 3
  Transaction? _transaccionAEditar;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    final modalRoute = ModalRoute.of(context);
    if (modalRoute != null && modalRoute.settings.arguments != null) {
      _transaccionAEditar = modalRoute.settings.arguments as Transaction;
      
      if (_amountController.text.isEmpty) {
        _amountController.text = _transaccionAEditar!.amount.toString();
        _descriptionController.text = _transaccionAEditar!.description;
        _selectedType = _transaccionAEditar!.type;
      }
    }
  }

  TransactionType _selectedType = TransactionType.expense;
  
  // Ejercicio 7
  String? _selectedCategory;
  List<String> _categories = [];

  @override
  void initState() {
    super.initState();
    _cargarCategorias();
  }

  Future<void> _cargarCategorias() async {
    final provider = context.read<TransactionProvider>();
    final cats = await provider.getCategories();
    setState(() {
      _categories = cats;

      if (_categories.isNotEmpty && _selectedCategory == null) {
        if (_transaccionAEditar != null) {
          _selectedCategory = _transaccionAEditar!.category;
        } else {
          _selectedCategory = _categories.first;
        }
      }
      
    });
  }

  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        title: Text('Registrar transaccion'),
      ), 

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
                  validator: (value) {  // Ejercicio 4
                    if (value == null || value.isEmpty) {
                      return 'Ingrese un monto';
                    }
                    
                    final number = double.tryParse(value);
                    if (number == null) {
                      return 'Ingrese un número válido';
                    }
                    
                    if (number <= 0) {
                      return 'El monto debe ser mayor a 0';
                    }
                    
                    return null;
                  },
                ),

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
                ),

                SizedBox(height: 20),
                // Ejercicio 7
                _categories.isEmpty 
                  ? const CircularProgressIndicator()
                  :DropdownButtonFormField(
                    value: _selectedCategory,
                    decoration: InputDecoration(
                      labelText: 'Categoria',
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Por favor, seleccione una categoría';
                      }
                      return null;
                    },  
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
                  ),

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

                            if (_transaccionAEditar == null) {

                              await provider.addTransaction(
                                Transaction(
                                  id: Uuid().v4(),
                                  category: _selectedCategory!,
                                  amount: double.parse(_amountController.text),
                                  description: _descriptionController.text,
                                  type: _selectedType,
                                  date: DateTime.now(),
                                ),
                              );

                            } else { 
                              await provider.updateTransaction(
                                Transaction(
                                  id: _transaccionAEditar!.id,
                                  category: _selectedCategory!,
                                  amount: double.parse(_amountController.text),
                                  description: _descriptionController.text,
                                  type: _selectedType,
                                  date: _transaccionAEditar!.date,
                                ),
                              );

                            }

                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text(
                                  _transaccionAEditar == null
                                      ? 'Transacción registrada'
                                      : 'Transacción editada',
                                ),
                              ),
                            );

                            if (context.mounted) {
                              Navigator.pop(context); 
                            }
                          }
                        },
                        child: Text(
                          _transaccionAEditar == null
                              ? 'Añadir Transacción'
                              : 'Editar Transacción',
                        ),
                      )



                ),

              ],
            ),

          ),
        ),
   ),


    );
  }
}