import 'package:flutter/material.dart';

import 'list_data.dart';

class AnimatedListView extends StatelessWidget {
  final Animation<EdgeInsets> listSlidePosition;

  AnimatedListView({@required this.listSlidePosition});

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.bottomCenter,
      children: <Widget>[
        ListData(
          title: "Descansar",
          subTitle: "de seg a seg",
          image: AssetImage('assets/user.png'),
          margin: listSlidePosition.value * 2,
        ),
        ListData(
          title: "Estudar Flutter",
          subTitle: "de seg a sex",
          image: AssetImage('assets/user.png'),
          margin: listSlidePosition.value * 1,
        ),
        ListData(
          title: "Trabalhar",
          subTitle: "de seg a sex",
          image: AssetImage('assets/user.png'),
          margin: listSlidePosition.value * 0,
        ),
      ],
    );
  }
}
