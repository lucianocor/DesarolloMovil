
class Recipe {
	final String id;
	final String title;
	final String description;
	final List<String> ingredients;
	final String imageURL;
	bool isFavorite;

	Recipe({
		required this.id,
		required this.title,
		required this.description,
		required this.ingredients,
		required this.imageURL,
		this.isFavorite = false
	});

}

