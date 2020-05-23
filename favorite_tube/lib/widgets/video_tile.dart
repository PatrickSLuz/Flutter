import 'package:favorite_tube/models/video.dart';
import 'package:flutter/material.dart';

class VideoTile extends StatelessWidget {
  final Video video;

  VideoTile(this.video);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 4),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          AspectRatio(
            aspectRatio: 16 / 9,
            child: Image.network(
              video.thumb,
              fit: BoxFit.cover,
            ),
          ),
          Row(
            children: [
              Expanded(
                  child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(8, 8, 8, 0),
                    child: Text(
                      video.title,
                      style: TextStyle(color: Colors.white, fontSize: 16),
                      maxLines: 2,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8),
                    child: Text(video.channel,
                        style: TextStyle(color: Colors.white, fontSize: 14)),
                  )
                ],
              )),
              IconButton(
                  icon: Icon(Icons.star_border),
                  color: Colors.white,
                  iconSize: 30,
                  onPressed: () {})
            ],
          )
        ],
      ),
    );
  }
}