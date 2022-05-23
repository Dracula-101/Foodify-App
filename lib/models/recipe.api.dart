import 'dart:convert';
import 'package:foodify/models/recipe.dart';
import 'package:http/http.dart' as http;
import 'package:foodify/constants/key.dart';
import 'package:foodify/constants/parameters.dart';

class RecipeApi {
  static Future<List<Recipe>> getRecipe() async {
    String personEating = "";
    if (getEating() == "") {
      personEating = cuisine;
    } else {
      personEating = cuisine + "," + getEating();
    }
    var uri = Uri.https(BASE_URL, '/recipes/random', {
      "number": "10",
      "tags": personEating,
      "apiKey": apiKey.first,
    });

    final response = await http.get(uri,
        headers: {"x-api-key": apiKey.first, "useQueryString": "true"});

    Map data = jsonDecode(response.body);
    // print(data);

    if (data['code'] == 402) {
      changeAPiKey();
      return getRecipe();
    }
    List _temp = [];

    for (var i in data['recipes']) {
      _temp.add(i);
    }
    // print(_temp);
    return Recipe.recipesFromSnapshot(_temp);
  }

  static Future<List<Recipe>> getTrending() async {
    var uri = Uri.https(BASE_URL, '/recipes/random', {
      "number": "10",
      "sort": "asc",
      "apiKey": apiKey.first,
    });

    final response = await http.get(uri,
        headers: {"x-api-key": apiKey.first, "useQueryString": "true"});

    Map data = jsonDecode(response.body);
    // print(data);
    if (data['code'] == 402) {
      changeAPiKey();
      return getTrending();
    }
    List _temp = [];

    for (var i in data['recipes']) {
      _temp.add(i);
    }
    // print(_temp);
    return Recipe.recipesFromSnapshot(_temp);
  }
}
