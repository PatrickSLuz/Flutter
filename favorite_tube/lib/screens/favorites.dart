import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:favorite_tube/api.dart';
import 'package:favorite_tube/blocs/favorite_bloc.dart';
import 'package:favorite_tube/models/video.dart';
import 'package:flutter/material.dart';
import 'package:flutter_youtube/flutter_youtube.dart';

class Favorites extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final bloc = BlocProvider.of<FavoriteBloc>(context);
    return Scaffold(
      backgroundColor: Colors.black87,
      appBar: AppBar(
        backgroundColor: Colors.black87,
        title: Text("Favoritos"),
        centerTitle: true,
      ),
      body: StreamBuilder<Map<String, Video>>(
        stream: bloc.outFavorite,
        initialData: {},
        builder: (context, snapshot) {
          return ListView(
            children: snapshot.data.values.map((video) {
              return InkWell(
                child: Row(
                  children: <Widget>[
                    Container(
                      width: 100,
                      height: 50,
                      child: Image.network(video.thumb),
                    ),
                    Expanded(
                      child: Text(
                        video.title,
                        style: TextStyle(color: Colors.white70),
                        maxLines: 2,
                      ),
                    )
                  ],
                ),
                onTap: () {
                  FlutterYoutube.playYoutubeVideoById(
                      apiKey: Api.apiKey, videoId: video.id);
                },
                onLongPress: () {
                  bloc.toggleFavorite(video);
                },
              );
            }).toList(),
          );
        },
      ),
    );
  }
}
