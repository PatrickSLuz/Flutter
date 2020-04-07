import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

void main() async {
  runApp(MyApp());

  // Escrever no Firebase
  //Firestore.instance.collection("mensagens").document().setData({"msg": "Oi 4", "from":"alguem 4"});

  // Ler do Firebase
  QuerySnapshot snapshot = await Firestore.instance.collection("mensagens").getDocuments();
  snapshot.documents.forEach((element) {
    print(element.data);
    print(element.documentID);
  });

  // Acessar apenas 1 document
  DocumentSnapshot docSnapshot = await Firestore.instance.collection("mensagens").document("0aSqUx7nSg0JhvwWReWI").get();
  print(docSnapshot.data);

  // Ler os dados do Firestore em Real Time por collections
  Firestore.instance.collection("mensagens").snapshots().listen((dado) {
    // ira entrar aqui quando houver uma atualizacao em algum dado no Firestore desta collection
    dado.documents.forEach((element) {
      print(element.data);
    });
  });

  // Ler os dados do Firestore em Real Time por documents
  Firestore.instance.collection("mensagens").document("nUskf1r8xKLPLYVMSc8U").snapshots().listen((dado) {
    // ira entrar aqui quando houver uma atualizacao em algum dado no Firestore deste document
      print(dado.data);
  });

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
