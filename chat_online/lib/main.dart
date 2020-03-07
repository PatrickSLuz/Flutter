import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp());

  // Testar config com o Firebase
  Firestore.instance
      .collection("col")
      .document("doc")
      .setData({"texto": "teste"});
}
