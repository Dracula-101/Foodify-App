import 'dart:developer';

import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:foodify/constants/key.dart';

class RecipeSuggestionAPI {
  static Future<List<String>> getSuggestion(String suggestion) async {
    var uri = Uri.https(BASE_URL, '/recipes/autocomplete', {
      "query": suggestion,
      "number": "10",
      "apiKey": apiKey.first,
    });

    final response = await http.get(uri,
        headers: {"x-api-key": apiKey.first, "useQueryString": "true"});

    List<dynamic> data = jsonDecode(response.body);
    print(data);

    // if (data['code'] == 402) {
    //   changeAPiKey();
    //   return getSuggestion(suggestion);
    // }
    // print(_temp);
    return suggestionfromSnap(data);
  }

  static List<String> suggestionfromSnap(temp) {
    List<String> list = [];
    for (int i = 0; i < temp.length; i++) {
      list.add(temp[i]['title']);
    }
    return list;
  }
}
