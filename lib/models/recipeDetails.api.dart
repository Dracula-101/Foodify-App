import 'dart:convert';
import 'package:foodify/models/recipeDetails.dart';
import 'package:http/http.dart' as http;
import 'package:foodify/constants/key.dart';

class RecipeDetailsAPI {
  static Future<List<RecipeDetails>> getRecipeDetails(String Id) async {
    var uri = Uri.https(BASE_URL, '/recipes/' + Id + '/information', {
      "apiKey": API_KEY,
    });

    final response = await http
        .get(uri, headers: {"x-api-key": API_KEY, "useQueryString": "true"});

    Map data = jsonDecode(response.body);
    List _temp = [];

    for (var i in data['']) {
      _temp.add(i);
    }
    print(_temp);

    return RecipeDetails.recipesFromSnapshotDetails(_temp);
  }
}
