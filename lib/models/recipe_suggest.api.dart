import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:foodify/constants/key.dart';

class RecipeSuggestionAPI {
  static Future<List<String>> getSuggestion(String suggestion) async {
    var uri = Uri.https(BASE_URL, '/recipes/autocomplete', {
      "number": "6",
      "query": suggestion,
      // "tags": cuisine + "," + getVeg(),
      "apiKey": apiKey.first,
    });

    final response = await http.get(uri,
        headers: {"x-api-key": apiKey.first, "useQueryString": "true"});

    Map data = jsonDecode(response.body);
    print(data);

    if (data['code'] == 402) {
      changeAPiKey();
      return getSuggestion(suggestion);
    }
    List<String> _temp = [];

    for (var i in data['recipes']) {
      _temp.add(i);
    }
    // print(_temp);
    return _temp;
  }
}
