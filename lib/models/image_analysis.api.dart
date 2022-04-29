import 'dart:convert';

import 'package:foodify/models/image_analysis.dart';
import 'package:http/http.dart' as http;
import 'package:foodify/constants/key.dart';

import 'image_analysis.api.dart';

class ImageAnalysisAPI {
  static Future<ImageAnalysis> getAnalysis(String img) async {
    String API_KEY = apiKey.first;
    var uri = Uri.https(BASE_URL, '/food/images/analyze', {
      "imageUrl": img,
      "apiKey": apiKey.first,
    });

    final response = await http.get(uri,
        headers: {"x-api-key": apiKey.first, "useQueryString": "true"});

    Map data = jsonDecode(response.body);
    print(data);

    if (data['code'] == 402) {
      changeAPiKey();
      return getAnalysis(img);
    }
    // print(_temp);
    return ImageAnalysis.fromJson(data);
  }
}
