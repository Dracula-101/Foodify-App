class Recipe {
  final int id;
  final String title;
  final String image;
  final double rating;
  final int readyInMinutes;

  Recipe(
      {required this.id,
      required this.title,
      required this.image,
      required this.rating,
      required this.readyInMinutes});

  factory Recipe.fromJson(dynamic json) {
    return Recipe(
        id: json['id'] as int,
        title: json['title'] as String,
        image: json['image'] as String,
        rating: (json['spoonacularScore'] as double) / 20.0,
        readyInMinutes: json['readyInMinutes'] as int);
  }

  static List<Recipe> recipesFromSnapshot(List snapshot) {
    // print(snapshot);
    return snapshot.map((data) {
      return Recipe.fromJson(data);
    }).toList();
  }

  @override
  String toString() {
    return 'Recipe {id: $id, name: $title, image: $image, rating: $rating, readyInMinutes: $readyInMinutes}';
  }
}
