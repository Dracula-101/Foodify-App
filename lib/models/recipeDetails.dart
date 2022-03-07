import 'package:foodify/models/recipe.dart';

class RecipeDetails {
  late String title;
  late String imageUrl;
  late int rating;
  late List<dynamic> ingredients;
  late List<dynamic> steps;
  late String id;

  RecipeDetails({
    required this.id,
    String? title,
    String? imageUrl,
    rating,
    List? ingredients,
    List? steps,
  });

  factory RecipeDetails.fromJson(dynamic json) {
    return RecipeDetails(
        title: json['title'] as String,
        imageUrl: json['image'] as String,
        rating: (json['spoonacularScore']) / 20,
        ingredients: (json['extendedIngredients'] as List)
            .map((e) => e['original'])
            .toList(),
        steps: (json['analyzedInstructions.steps'] as List),
        id: json['id']);
  }

  static List<RecipeDetails> recipesFromSnapshotDetails(List snapshot) {
    return snapshot.map((data) {
      return RecipeDetails.fromJson(data);
    }).toList();
  }

  @override
  String toString() {
    return 'RecipeDetails {name: $title, image: $imageUrl, rating: $rating, ingredients: $ingredients, steps: $steps}';
  }
}
