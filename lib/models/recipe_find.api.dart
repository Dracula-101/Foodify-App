import 'dart:convert';
import 'package:foodify/models/recipe_find.dart';
import 'package:http/http.dart' as http;
import 'package:foodify/constants/key.dart';

class RecipeFindApi {
  static Future<List<RecipeFind>> getRecipe(
      String ingredients, String ranking, bool pantry) async {
    var uri = Uri.https(BASE_URL, '/recipes/findByIngredients', {
      "number": items.toString(),
      "ingredients": ingredients,
      "ranking": ranking,
      "pantry": pantry == true ? "true" : "false",
      "apiKey": apiKey.first,
    });

    final response = await http.get(uri,
        headers: {"x-api-key": apiKey.first, "useQueryString": "true"});
    // print(jsonDecode(response.body));
    if (response.statusCode != 200) {
      changeAPiKey();
      return getRecipe(ingredients, ranking, pantry);
    }
    List data = jsonDecode(response.body);
    List _temp = [];

    for (var i in data) {
      // print(i);
      _temp.add(i);
    }
    // print(_temp);
    return RecipeFind.recipesFromSnapshot(_temp);
  }
}
