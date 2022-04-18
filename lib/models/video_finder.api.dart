import 'dart:convert';

import 'package:foodify/constants/key.dart';
import 'package:foodify/views/widgets/video_widget.dart';
import 'package:http/http.dart' as http;

class VideoFinderAPI {
  static Future<List<Videos>> getVideos() async {
    var uri = Uri.https(BASE_URL, '/food/videos/search', {
      "number": "10",
      // "tags": cuisine + "," + getVeg(),
      "apiKey": apiKey.first,
    });

    final response = await http.get(uri,
        headers: {"x-api-key": apiKey.first, "useQueryString": "true"});

    Map data = jsonDecode(response.body);
    // print(data);
    if (data['code'] == 402) {
      changeAPiKey();
      return getVideos();
    }
    List _temp = [];

    for (var i in data['videos']) {
      _temp.add(i);
    }
    print(_temp);
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
      length: json['length'],
      thumbnail: json['thumbnail'],
      youtubeId: json['youtubeId'],
      views: json['views'],
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
