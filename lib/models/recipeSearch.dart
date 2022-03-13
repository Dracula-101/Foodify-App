// ignore_for_file: file_names

class RecipeSearch {
  final int id;
  final String title;
  final String image;
  final int cookTime;
  final double rating;

  RecipeSearch(
      {required this.id,
      required this.title,
      required this.image,
      required this.cookTime,
      required this.rating
      // required this.calories,
      // required this.proteins,
      });

  factory RecipeSearch.fromJson(dynamic json) {
    print(json);
    return RecipeSearch(
      id: json['id'] as int,
      title: json['title'] as String,
      image: json['image'] as String,
      cookTime: json['readyInMinutes'] as int,
      rating: (json['spoonacularScore'] as double) / 20.0,
      // calories: json['nutrition.nutrients.amount'] as int,
      // proteins: json['nutrition.nutrients.amount'] as int
    );
  }

  static List<RecipeSearch> recipeSearchFromSnapshot(List snapshot) {
    return snapshot.map((data) {
      return RecipeSearch.fromJson(data);
    }).toList();
  }

  @override
  String toString() {
    return 'RecipeSearch {id: $id, name: $title, image: $image, cookTime: $cookTime, rating: $rating}';
  }
}
