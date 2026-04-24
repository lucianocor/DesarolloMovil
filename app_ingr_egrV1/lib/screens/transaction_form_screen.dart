import 'package:flutter/material.dart';




class TransactionFormScreen extends StatefulWidget{
  TransactionFormScreen({super.key});

  @override
  State<TransactionFormScreen> createState() => _TransactionFormScreenState();
}

class _TransactionFormScreenState extends State<TransactionFormScreen>{
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _amountController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();

  String _selectedCategory = 'Comida';

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

      body: Padding(
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

              Center(
                child: ElevatedButton(
                  onPressed: (){
                    if (_formKey.currentState!.validate()){
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('Transaccion registrada')),);
                      
                      Navigator.pop(context);
                    } 
                  },
                  child: Text('Guardar transaccion'),
                ), // elevatedbutton
              ), // center

            ], // children
          ), // column

        ), // form
      ),
    ); // scaffold
  }
}
