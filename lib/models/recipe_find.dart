class RecipeFind {
  final int id;
  final String title;
  final String image;
  final int missedIngredientCount;
  final int usedIngredientCount;
  final List<dynamic> missedIngredients;
  final List<dynamic> usedIngredients;
  final int likes;

  RecipeFind({
    required this.missedIngredientCount,
    required this.usedIngredientCount,
    required this.likes,
    required this.id,
    required this.title,
    required this.image,
    required this.missedIngredients,
    required this.usedIngredients,
  });

  factory RecipeFind.fromJson(dynamic json) {
    // print("Name of the recipe: ${json['title']}");
    // print("Missed: ${json['missedIngredientCount']}");
    // print("Used: ${json['usedIngredientCount']}");

    //print("Missed Ingredients: ${json['missedIngredients']}\n\n");
    //print("Used Ingredients: ${json['usedIngredients']}");
    return RecipeFind(
      id: json['id'] as int,
      title: json['title'] as String,
      image: json['image'] == null
          ? "https://bitsofco.de/content/images/2018/12/broken-1.png"
          : json['image'] as String,
      missedIngredientCount: json['missedIngredientCount'] as int,
      usedIngredientCount: json['usedIngredientCount'] as int,
      likes: json['likes'] as int,
      missedIngredients: json['missedIngredients'] as List<dynamic>,
      usedIngredients: json['usedIngredients'] as List<dynamic>,
    );
  }

  static List<RecipeFind> recipesFromSnapshot(List snapshot) {
    // print(snapshot);
    return snapshot.map((data) {
      return RecipeFind.fromJson(data);
    }).toList();
  }

  @override
  String toString() {
    return 'RecipeFindCard {id: $id, name: $title, image: $image, usedIngredientsCount: $usedIngredientCount, missedIngredientCount: $missedIngredientCount, likes: $likes, missedIngredients: $missedIngredients, usedIngredients: $usedIngredients}';
  }
}
