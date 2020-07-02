import 'dart:async';
import 'dart:convert';

import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:favorite_tube/models/video.dart';
import 'package:rxdart/rxdart.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FavoriteBloc implements BlocBase {
  Map<String, Video> _favorites = {};

  FavoriteBloc() {
    SharedPreferences.getInstance().then((prefs) {
      if (prefs.getKeys().contains('favorites')) {
        _favorites =
            json.decode(prefs.getString('favorites')).map((key, value) {
          return MapEntry(key, Video.fromJson(value));
        }).cast<String, Video>();
        _favController.sink.add(_favorites);
      }
    });
  }

  final _favController = BehaviorSubject<Map<String, Video>>();
  Stream<Map<String, Video>> get outFavorite => _favController.stream;

  void toggleFavorite(Video video) {
    if (_favorites.containsKey(video.id)) {
      _favorites.remove(video.id);
    } else {
      _favorites[video.id] = video;
    }
    _favController.sink.add(_favorites);

    _saveFavorite();
  }

  void _saveFavorite() {
    SharedPreferences.getInstance().then((prefs) {
      prefs.setString('favorites', json.encode(_favorites));
    });
  }

  @override
  void dispose() {
    _favController.close();
  }
}
