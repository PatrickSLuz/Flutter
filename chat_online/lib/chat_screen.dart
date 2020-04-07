import 'dart:io';

import 'package:chat_online/text_composer.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';

class ChatScreen extends StatefulWidget {
  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {

  Map<String, dynamic> data = {};

  void _sendMessage({String msg, File imgFile}) async {
    if (imgFile != null) {
      StorageUploadTask task = FirebaseStorage.instance.ref().child(
        DateTime.now().millisecondsSinceEpoch.toString()
      ).putFile(imgFile);

      StorageTaskSnapshot taskSnapshot = await task.onComplete;
      // Pegar Url da imagem dps de salvar
      String url = await taskSnapshot.ref.getDownloadURL();
      data["imgUrl"] = url;
    }

    if (msg != null) {
      data["text"] = msg;
    }

    Firestore.instance.collection("messages").add(data);
    data.clear();

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("OLA"),
        elevation: 0,
      ),
      body: Column(
        children: <Widget>[
          Expanded(
            child: StreamBuilder<QuerySnapshot>(
              stream: Firestore.instance.collection("messages").snapshots(),
              builder: (context, snapshot){
                switch(snapshot.connectionState){
                  case ConnectionState.none:
                  case ConnectionState.waiting:
                    return Center(
                      child: CircularProgressIndicator()
                    );
                  default:
                    List<DocumentSnapshot> documents = snapshot.data.documents.reversed.toList();
                    return ListView.builder(
                      itemCount: documents.length,
                        reverse: true,
                        itemBuilder: (context, index){
                          return ListTile(
                            title: Text(documents[index].data["text"]),
                          );
                        }
                    );
                }
              },
            ),
          ),
          TextComposer(_sendMessage)
        ],
      ),
    );
  }
}
