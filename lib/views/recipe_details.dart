class RecipeID {
  late String title;
  late String imageUrl;
  late int rating;
  late List<dynamic> ingredients;
  late List<dynamic> steps;
  late String recipeId;
  late String summary;

  RecipeID({
    required this.recipeId,
    String? title,
    String? imageUrl,
    rating,
    List? ingredients,
    List? steps,
    String? summary,
  });

  factory RecipeID.fromJson(dynamic json) {
    return RecipeID(
        title: json['title'] as String,
        imageUrl: json['image'] as String,
        rating: (json['spoonacularScore']) / 20,
        ingredients: (json['extendedIngredients'] as List)
            .map((e) => e['original'])
            .toList(),
        steps: (json['analyzedInstructions.steps'] as List),
        recipeId: json['id'],
        summary: json['summary']);
  }

  static List<RecipeID> recipesFromSnapshotDetails(List snapshot) {
    return snapshot.map((data) {
      return RecipeID.fromJson(data);
    }).toList();
  }

  @override
  String toString() {
    return 'recipeID {name: $title, image: $imageUrl, rating: $rating, ingredients: $ingredients, steps: $steps,summary: $summary}';
  }
}
