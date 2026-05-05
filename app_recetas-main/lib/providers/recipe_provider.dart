import 'package:flutter/material.dart';
import 'package:app_recetas/models/recipe.dart';

class RecipeProvider with ChangeNotifier{
	List<Recipe> _recipes = [];
	List<Recipe> get recipes => _recipes;


	void addRecipe(Recipe recipe){
		_recipes.add(recipe);
		notifyListeners();
	}


	void toggleFavorite(String id){
		final index = _recipes.indexWhere((recipe) => recipe.id == id);

		if (index!=-1){
			_recipes[index].isFavorite = !_recipes[index].isFavorite;
			notifyListeners();
		}
	}

}
