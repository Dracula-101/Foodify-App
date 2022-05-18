import 'dart:convert';

import 'package:foodify/constants/key.dart';
import 'package:foodify/views/widgets/video_widget.dart';
import 'package:http/http.dart' as http;

class VideoFinderAPI {
  static Future<List<Videos>> getVideos(String query) async {
    var uri = Uri.https(BASE_URL, '/food/videos/search', {
      "number": "15",
      "query": query,
      // "tags": cuisine + "," + getVeg(),
      "apiKey": apiKey.first,
    });

    print('vid uri is' + uri.toString());

    final response = await http.get(uri,
        headers: {"x-api-key": apiKey.first, "useQueryString": "true"});

    print('vid res is ok' + response.toString());
    Map data = jsonDecode(response.body);
    print('vid data is' + data.toString());

    // print(data);
    if (data['code'] == 402) {
      changeAPiKey();
      return getVideos(query);
    }
    List _temp = [];

    for (var i in data['videos']) {
      _temp.add(i);
    }
    return Videos.videoesFromSnapshot(_temp);
  }
}

class Videos {
  final String title, length, thumbnail, youtubeId, views;
  Videos(
      {required this.title,
      required this.length,
      required this.thumbnail,
      required this.youtubeId,
      required this.views});

  factory Videos.fromJson(dynamic json) {
    return Videos(
      title: json['title'],
      length: json['length'].toString(),
      thumbnail: json['thumbnail'],
      youtubeId: json['youTubeId'],
      views: json['views'].toString(),
    );
  }

  static List<Videos> videoesFromSnapshot(List snapshot) {
    return snapshot.map((data) {
      return Videos.fromJson(data);
    }).toList();
  }

  @override
  String toString() {
    return 'Videos {title: $title, length: $length, thumbnail: $thumbnail, youtubeId: $youtubeId, views: $views}';
  }
}
