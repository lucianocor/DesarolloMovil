import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:app_recetas/providers/recipe_provider.dart';
import 'package:app_recetas/models/recipe.dart';
import 'package:uuid/uuid.dart';


class AddRecipeScreen extends StatefulWidget{
	const AddRecipeScreen({super.key});

	@override
	State<AddRecipeScreen> createState() => _AddRecipeScreenState();

}

class _AddRecipeScreenState extends State<AddRecipeScreen>{
	final _formKey = GlobalKey<FormState>();
	final _titleController = TextEditingController();
	final _descriptionController = TextEditingController();
	final _ingredientsController = TextEditingController();
	final _imageURLController = TextEditingController();


	void _submitForm(){
		if (_formKey.currentState!.validate()){
			final newRecipe = Recipe (
				id: Uuid().v4(),
				title: _titleController.text,
				description: _descriptionController.text,
				ingredients: _ingredientsController.text.split(','),
				imageURL: _imageURLController.text,

			);


			Provider.of<RecipeProvider>(context,listen:false).addRecipe(newRecipe);
			Navigator.of(context).pop();

		}

	}



	

	@override
	Widget build(BuildContext context){
		return Scaffold(
			body:
				Padding(
							padding: const EdgeInsets.all(16.0),
							child: Form(
								key: _formKey,
								child: Column(

									children: [
										TextFormField(
											controller: _titleController,
											decoration: const InputDecoration(labelText: 'Titulo de la receta'),

											validator: (value) {
												if (value == null || value.isEmpty){
													return 'For favor ingrese un titulo';

												}
												return null;
											},
										),

										const SizedBox(height: 10),


										TextFormField(
											controller: _descriptionController,
											decoration: const InputDecoration(labelText: 'Descripcion de la receta'),

											validator: (value) {
												if (value == null || value.isEmpty){
													return 'For favor ingrese una descripcion';

												}
												return null;
											},
										),


										const SizedBox(height: 10),

										TextFormField(
											controller: _ingredientsController,
											decoration: const InputDecoration(labelText: 'Ingredientes (separados por comas)'),

											validator: (value) {
												if (value == null || value.isEmpty){
													return 'For favor ingrese los ingredientes';

												}
												return null;
											},
										),


										const SizedBox(height: 10),

										TextFormField(
											controller: _imageURLController,
											decoration: const InputDecoration(labelText: 'URL de la imagen de la comida'),

											validator: (value) {
												if (value == null || value.isEmpty){
													return 'For favor ingrese una URL';

												}
												return null;
											},
										),


										const SizedBox(height: 10),

										ElevatedButton(
											onPressed: _submitForm,
											child: const Text('Añadir Receta'),
										),

									],



								),

							),



						),						




		);

	}

}
