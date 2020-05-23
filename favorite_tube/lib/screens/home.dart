import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:favorite_tube/blocs/videos_bloc.dart';
import 'package:favorite_tube/delegates/data_search.dart';
import 'package:favorite_tube/models/video.dart';
import 'package:favorite_tube/widgets/video_tile.dart';
import 'package:flutter/material.dart';

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: Container(
          height: 25,
          child: Image.asset('assets/images/youtube_logo.png'),
        ),
        elevation: 0,
        backgroundColor: Colors.black87,
        actions: [
          Align(
            alignment: Alignment.center,
            child: Text("0"),
          ),
          IconButton(
            icon: Icon(Icons.star),
            onPressed: () {},
          ),
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () async {
              String result =
                  await showSearch(context: context, delegate: DataSearch());
              if (result != null) {
                BlocProvider.of<VideosBloc>(context).inSearch.add(result);
              }
            },
          )
        ],
      ),
      body: StreamBuilder<List<Video>>(
        stream: BlocProvider.of<VideosBloc>(context).outVideos,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return ListView.builder(
              itemCount: snapshot.data.length,
              itemBuilder: (context, index) {
                return VideoTile(snapshot.data[index]);
              },
            );
          } else {
            return Container();
          }
        },
      ),
    );
  }
}