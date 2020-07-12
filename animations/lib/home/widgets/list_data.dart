import 'package:flutter/material.dart';

class ListData extends StatelessWidget {
  final String title;
  final String subTitle;
  final ImageProvider image;
  final EdgeInsets margin;

  ListData({this.title, this.subTitle, this.image, this.margin});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: margin,
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border(
          top: BorderSide(color: Colors.grey[300], width: 1.0),
          bottom: BorderSide(color: Colors.grey[300], width: 1.0),
        ),
      ),
      child: Row(
        children: <Widget>[
          Container(
            margin: const EdgeInsets.fromLTRB(20, 10, 20, 10),
            width: 60,
            height: 60,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              image: DecorationImage(image: image),
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                title,
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w400,
                ),
              ),
              SizedBox(height: 5),
              Text(
                subTitle,
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.grey,
                  fontWeight: FontWeight.w300,
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
