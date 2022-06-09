import 'package:http/http.dart' as http;
import 'dart:io' as file;
import '../constants/key.dart';

class RemoveBgAPI {
  static Future<void> getImage(file.File image) async {
    final body = {"image_file": image.path, "size": "auto"};
    var uri = Uri.https("api.remove.bg", '/v1.0/removebg', {
      "image_file": image.path.toString(),
      "apiKey": removeBgKey,
    });
    final headers = {
      "X-API-Key": removeBgKey,
      "useQueryString": "true",
    };
    final response = await http.post(uri, body: body, headers: headers);

    if (response.statusCode == 200) {
      // do something with response.body
    } else {
      throw Exception(
          'Failed to do network requests: Error Code: ${response.statusCode}\nBody: ${response.body}');
    }
  }
}
