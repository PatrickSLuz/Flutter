import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:favorite_tube/blocs/favorite_bloc.dart';
import 'package:favorite_tube/blocs/videos_bloc.dart';
import 'package:favorite_tube/screens/home.dart';
import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      bloc: VideosBloc(),
      child: BlocProvider(
        bloc: FavoriteBloc(),
        child: MaterialApp(
          title: 'Flutter Tube',
          home: Home(),
        ),
      ),
    );
  }
}
