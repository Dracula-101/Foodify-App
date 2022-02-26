class Recipe {
  final String title;
  final String image;
  final int weightWatcherSmartPoints;
  final int readyInMinutes;

  Recipe(
      {required this.title,
      required this.image,
      required this.weightWatcherSmartPoints,
      required this.readyInMinutes});

  factory Recipe.fromJson(dynamic json) {
    return Recipe(
        title: json['title'] as String,
        image: json['image'] as String,
        weightWatcherSmartPoints: json['weightWatcherSmartPoints'] as int,
        readyInMinutes: json['readyInMinutes'] as int);
  }

  static List<Recipe> recipesFromSnapshot(List snapshot) {
    return snapshot.map((data) {
      return Recipe.fromJson(data);
    }).toList();
  }

  @override
  String toString() {
    return 'Recipe {name: $title, image: $image, weightWatcherSmartPoints: $weightWatcherSmartPoints, readyInMinutes: $readyInMinutes}';
  }
}
