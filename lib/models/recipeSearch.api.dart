import 'dart:convert';
import 'package:foodify/models/recipeSearch.dart';
import 'package:http/http.dart' as http;
import 'package:foodify/constants/key.dart';
import 'package:foodify/constants/parameters.dart';

class RecipeSearchApi {
  static Future<List<RecipeSearch>> getRecipe(String title) async {
    var uri = Uri.https(BASE_URL, '/recipes/complexSearch', {
      "number": "15",
      "addRecipeNutrition": "true",
      "sort": "calories",
      "sortDirection": "asc",
      "titleMatch": title,
      "instructionsRequired": "true",
      "tags": cuisine + "," + getEating(),
      "apiKey": apiKey.first,
    });

    final response = await http.get(uri, headers: {"useQueryString": "true"});
    if (response.statusCode != 200) {
      changeAPiKey();
      return getRecipe(title);
    }
    Map data = jsonDecode(response.body);
    List _temp = [];

    for (var i in data['results']) {
      _temp.add(i);
    }
    return RecipeSearch.recipeSearchFromSnapshot(_temp);
  }

  static Future<List<RecipeSearch>> getCuisine(String cuisine) async {
    var uri = Uri.https(BASE_URL, '/recipes/complexSearch', {
      "number": "30",
      "addRecipeNutrition": "true",
      "sort": "calories",
      "sortDirection": "asc",
      "instructionsRequired": "true",
      "cuisine": cuisine,
      "tags": getEating(),
      "apiKey": apiKey.first,
    });

    final response = await http.get(uri, headers: {"useQueryString": "true"});
    if (response.statusCode != 200) {
      changeAPiKey();
      return getCuisine(cuisine);
    }
    Map data = jsonDecode(response.body);
    List _temp = [];

    for (var i in data['results']) {
      _temp.add(i);
    }
    return RecipeSearch.recipeSearchFromSnapshot(_temp);
  }
}
