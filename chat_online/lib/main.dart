import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());

  // Testar config com o Firebase
  Firestore.instance
      .collection("mensagens")
      .document()
      .setData({"msg": "Oi 4", "from":"alguem 4"});
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Flutter Demo",
      theme: ThemeData(
        primarySwatch: Colors.blue
      ),
      home: Container(),
    );
  }
}
