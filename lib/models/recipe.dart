import 'dart:math';

class Recipe {
  final int id;
  final String title;
  final String image;
  final double rating;
  final int readyInMinutes;
  final bool vegetarian;

  Recipe(
      {required this.id,
      required this.title,
      required this.image,
      required this.rating,
      required this.readyInMinutes,
      required this.vegetarian});

  factory Recipe.fromJson(dynamic json) {
    return Recipe(
        id: json['id'] as int,
        title: json['title'] as String,
        image: json['image'] == null
            ? "https://bitsofco.de/content/images/2018/12/broken-1.png"
            : json['image'] as String,
        rating: json['spoonacularScore'] != null
            ? (json['spoonacularScore'] as double) / 20.0
            : (json['weightWatcherSmartPoints'] as int) / 5.0,
        readyInMinutes: json['readyInMinutes'] as int,
        vegetarian: json['vegetarian'] as bool);
  }

  static List<Recipe> recipesFromSnapshot(List snapshot) {
    // print(snapshot);
    return snapshot.map((data) {
      return Recipe.fromJson(data);
    }).toList();
  }

  static double roundOffToXDecimal(double number, {int numberOfDecimal = 2}) {
    // To prevent number that ends with 5 not round up correctly in Dart (eg: 2.275 round off to 2.27 instead of 2.28)
    String numbersAfterDecimal = number.toString().split('.')[1];
    if (numbersAfterDecimal != '0') {
      int existingNumberOfDecimal = numbersAfterDecimal.length;
      number += 1 / (10 * pow(10, existingNumberOfDecimal));
    }

    return double.parse(number.toStringAsFixed(numberOfDecimal));
  }

  @override
  String toString() {
    return 'Recipe {id: $id, name: $title, image: $image, rating: $rating, readyInMinutes: $readyInMinutes, vegetarian: $vegetarian}';
  }
}
