import 'package:flutter/material.dart';
import 'package:app_recetas/models/recipe.dart';


class RecipeItem extends StatelessWidget{
	final Recipe recipe;
	const RecipeItem({super.key, required this.recipe});


	@override
	Widget build(BuildContext context){
		return Card(
			margin: EdgeInsets.all(8.0),
			child: ListTile(
				leading: CircleAvatar(
					backgroundImage: NetworkImage(recipe.imageURL),

				),
				title: Text(recipe.title),
				subtitle: Text(recipe.description),
				trailing: IconButton (
					onPressed: (){
						//

					},

					icon:Icon(
						recipe.isFavorite ? Icons.favorite_border_outlined : Icons.favorite_border_outlined,
						color: recipe.isFavorite ? Colors.red : null,
					),

				),


			),

		);
	}


}



