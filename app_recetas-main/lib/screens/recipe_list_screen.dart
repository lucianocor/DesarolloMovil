import 'package:flutter/material.dart';
import 'package:app_recetas/providers/recipe_provider.dart';
import 'package:provider/provider.dart';
import 'package:app_recetas/widgets/recipe_item.dart';
import 'package:app_recetas/screens/add_recipe_screen.dart';


class RecipeListScreen extends StatelessWidget {
	const RecipeListScreen({super.key});

	@override
	Widget build(BuildContext context){
		final recipeProvider = Provider.of<RecipeProvider>(context);
		final recipes = recipeProvider.recipes;



		return Scaffold(
			appBar: AppBar(
				title: const Text('Recetas de Cocina ')
			),

			body: recipes.isEmpty
			? Center(
				child: Text('No hay recetas. Añade algunas.'),
			  )
			: ListView.builder(
				itemCount: recipes.length,
				itemBuilder: (context, index) {
					return RecipeItem(recipe: recipes[index]);
				},
			),		

				floatingActionButton: FloatingActionButton(
					onPressed: () {
						Navigator.of(context).push(MaterialPageRoute(
							builder: (context) => const AddRecipeScreen()
						));

					},

					child: const Icon(Icons.add),

				),
			
		);
	}

}

