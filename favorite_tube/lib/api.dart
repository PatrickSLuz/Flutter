import 'dart:convert';

import 'package:favorite_tube/models/video.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:yaml/yaml.dart';

//https://www.googleapis.com/youtube/v3/search?part=snippet&q=$_search&type=video&key=$API_KEY&maxResults=10&pageToken=$_nextToken

class Api {
  var apiKey;

  Api() {
    if (apiKey == null) {
      initApiKey();
    }
  }

  initApiKey() async {
    var envFile = await rootBundle.loadString('env/api_info.yaml');
    var doc = loadYaml(envFile);

    apiKey = doc['API_KEY'];
  }

  search(String search) async {
    String urlSearch =
        "https://www.googleapis.com/youtube/v3/search?part=snippet&q=$search&type=video&key=$apiKey&maxResults=10";
    http.Response response = await http.get(urlSearch);

    return decode(response);
  }

  List<Video> decode(http.Response response) {
    if (response.statusCode == 200) {
      var decoded = json.decode(response.body);
      List<Video> videos = decoded['items'].map<Video>((map) {
        return Video.fromJson(map);
      }).toList();
      return videos;
    } else {
      throw Exception("Failed to load videos");
    }
  }
}
