// ignore: camel_case_types
class recipeID {
  late String title;
  late String imageUrl;
  late int rating;
  late List<dynamic> ingredients;
  late List<dynamic> steps;
  late String recipeId;
  late String summary;

  recipeID({
    required this.recipeId,
    String? title,
    String? imageUrl,
    rating,
    List? ingredients,
    List? steps,
    String? summary,
  });

  factory recipeID.fromJson(dynamic json) {
    return recipeID(
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

  static List<recipeID> recipesFromSnapshotDetails(List snapshot) {
    return snapshot.map((data) {
      return recipeID.fromJson(data);
    }).toList();
  }

  @override
  String toString() {
    return 'recipeID {name: $title, image: $imageUrl, rating: $rating, ingredients: $ingredients, steps: $steps,summary: $summary}';
  }
}
