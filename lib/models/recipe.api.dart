import 'dart:convert';
import 'package:foodify/models/recipe.dart';
import 'package:http/http.dart' as http;
import 'package:foodify/constants/key.dart';

class RecipeApi {
  static Future<List<Recipe>> getRecipe() async {
    var uri = Uri.https(BASE_URL, '/recipes/random', {
      "number": items.toString(),
      ""
          "apiKey": API_KEY,
    });

    final response = await http
        .get(uri, headers: {"x-api-key": API_KEY, "useQueryString": "true"});

    Map data = jsonDecode(response.body);
    List _temp = [];

    for (var i in data['recipes']) {
      _temp.add(i);
    }
    // print(_temp);
    return Recipe.recipesFromSnapshot(_temp);
  }
}
