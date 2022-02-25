import 'package:foodify/models/recipe.dart';

class recipeDetails {
  late String title;
  late String imageUrl;
  late int rating;
  late List<dynamic> ingredients;
  late List<dynamic> steps;
  late String recipeId;

  recipeDetails({
    required this.recipeId,
    String? title,
    String? imageUrl,
    rating,
    List? ingredients,
    List? steps,
  });

  factory recipeDetails.fromJson(dynamic json) {
    return recipeDetails(
        title: json['title'] as String,
        imageUrl: json['image'] as String,
        rating: (json['spoonacularScore']) / 20,
        ingredients: (json['extendedIngredients'] as List)
            .map((e) => e['original'])
            .toList(),
        steps: (json['analyzedInstructions.steps'] as List),
        recipeId: json['id']);
  }

  static List<recipeDetails> recipesFromSnapshotDetails(List snapshot) {
    return snapshot.map((data) {
      return recipeDetails.fromJson(data);
    }).toList();
  }

  @override
  String toString() {
    return 'recipeDetails {name: $title, image: $imageUrl, rating: $rating, ingredients: $ingredients, steps: $steps}';
  }
}
