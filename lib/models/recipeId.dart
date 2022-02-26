// To parse this JSON data, do

//     final recipeId = recipeIdFromJson(jsonString);

import 'dart:convert';

RecipeId recipeIdFromJson(String str) => RecipeId.fromJson(json.decode(str));

String recipeIdToJson(RecipeId data) => json.encode(data.toJson());

class RecipeId {
  RecipeId({
    this.vegetarian,
    this.spoonacularScore,
    this.healthScore,
    this.extendedIngredients,
    this.id,
    this.title,
    this.readyInMinutes,
    this.sourceUrl,
    this.image,
    this.instructions,
    this.analyzedInstructions,
  });

  bool? vegetarian;
  int? spoonacularScore;
  int? healthScore;
  List<ExtendedIngredient>? extendedIngredients;
  int? id;
  String? title;
  int? readyInMinutes;
  int? servings;
  String? sourceUrl;
  String? image;
  String? instructions;
  List<dynamic>? analyzedInstructions;

  factory RecipeId.fromJson(Map<String, dynamic> json) => RecipeId(
        vegetarian: json["vegetarian"],
        spoonacularScore: json["spoonacularScore"],
        healthScore: json["healthScore"],
        extendedIngredients: json["extendedIngredients"] == null
            ? null
            : List<ExtendedIngredient>.from(json["extendedIngredients"]
                .map((x) => ExtendedIngredient.fromJson(x))),
        id: json["id"],
        title: json["title"],
        readyInMinutes: json["readyInMinutes"],
        instructions: json["instructions"],
        analyzedInstructions: json["analyzedInstructions"] == null
            ? null
            : List<dynamic>.from(json["analyzedInstructions"].map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "vegetarian": vegetarian,
        "extendedIngredients": extendedIngredients == null
            ? null
            : List<dynamic>.from(extendedIngredients!.map((x) => x.toJson())),
        "id": id,
        "title": title,
        "readyInMinutes": readyInMinutes,
        "servings": servings,
        "sourceUrl": sourceUrl,
        "image": image,
      };

  static List<RecipeId> recipeSearchFromSnapshot(List snapshot) {
    return snapshot.map((data) {
      return RecipeId.fromJson(data);
    }).toList();
  }
}

class ExtendedIngredient extends RecipeId {
  ExtendedIngredient({
    this.id,
    this.image,
    this.name,
    this.amount,
    this.unit,
  });

  int? id;
  String? aisle;
  String? image;
  String? name;
  double? amount;
  String? unit;

  factory ExtendedIngredient.fromJson(Map<String, dynamic> json) =>
      ExtendedIngredient(
        id: json["id"],
        image: json["image"],
        name: json["name"],
        amount: json["amount"] == null ? null : json["amount"].toDouble(),
        unit: json["unit"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "aisle": aisle,
        "image": image,
        "name": name,
        "amount": amount,
        "unit": unit,
      };

  static List<ExtendedIngredient> recipeSearchFromSnapshot(List snapshot) {
    return snapshot.map((data) {
      return ExtendedIngredient.fromJson(data);
    }).toList();
  }
}
