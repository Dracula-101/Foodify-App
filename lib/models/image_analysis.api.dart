import 'dart:convert';
import 'dart:developer';

import 'package:foodify/models/image_analysis.dart';
import 'package:http/http.dart' as http;
import 'package:foodify/constants/key.dart';

class ImageAnalysisAPI {
  static int breakLoop = 5;
  static Future<ImageAnalysis> getAnalysis(String img) async {
    print('img url is' + img);
    print(img);
    log('img url is' + img);
    log(img);
    var uri = Uri.https(BASE_URL, '/food/images/analyze', {
      "imageUrl": img,
      "apiKey": apiKey.first,
    });
    var request = http.Request('GET', uri);

    http.StreamedResponse response1 = await request.send();

    String API_KEY = apiKey.first;

    Map data = jsonDecode(await response1.stream.bytesToString());
    print(data);

    if (data['code'] == 402 && breakLoop > 0) {
      changeAPiKey();
      breakLoop--;
      return getAnalysis(img);
    }
    // print(_temp);
    return ImageAnalysis.fromJson(data);
  }
}
