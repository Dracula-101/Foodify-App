class RecipeSearch {
  final String id;
  final String title;
  final String image;

  RecipeSearch({required this.id, required this.title, required this.image});

  factory RecipeSearch.fromJson(dynamic json) {
    return RecipeSearch(
        id: json['id'] as String,
        title: json['title'] as String,
        image: json['image'] as String);
  }

  static List<RecipeSearch> recipeSearchFromSnapshot(List snapshot) {
    return snapshot.map((data) {
      return RecipeSearch.fromJson(data);
    }).toList();
  }

  @override
  String toString() {
    return 'RecipeSearch {title: $title, id: $id, image: $image}';
  }
}
