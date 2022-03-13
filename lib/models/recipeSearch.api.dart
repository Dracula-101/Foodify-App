import 'dart:convert';
import 'package:foodify/models/recipeSearch.dart';
import 'package:http/http.dart' as http;
import 'package:foodify/constants/key.dart';

class RecipeSearchApi {
  static Future<List<RecipeSearch>> getRecipe(String title) async {
    var uri = Uri.https(BASE_URL, '/recipes/complexSearch', {
      "number": "15",
      "addRecipeNutrition": "true",
      "sort": "calories",
      "sortDirection": "asc",
      "titleMatch": title,
      "apiKey": API_KEY,
    });

    final response = await http.get(uri, headers: {"useQueryString": "true"});

    Map data = jsonDecode(response.body);
    List _temp = [];

    for (var i in data['results']) {
      _temp.add(i);
    }
    return RecipeSearch.recipeSearchFromSnapshot(_temp);
  }
}
