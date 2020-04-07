import 'dart:io';

import 'package:chat_online/chat_message.dart';
import 'package:chat_online/text_composer.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

class ChatScreen extends StatefulWidget {
  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {

  final GoogleSignIn googleSignIn = GoogleSignIn();

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  FirebaseUser _currentUser;
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();

    // sempre que a autenticacao mudar vai executar a funcao
    FirebaseAuth.instance.onAuthStateChanged.listen((user) {
      // quando logado tem o usuario // quando deslogado tem null
      setState(() {
        _currentUser = user;
      });
    });
  }

  Future<FirebaseUser> _getUser() async {
    // se esta logado retorna o user atual
    if (_currentUser != null) return _currentUser;

    // senao faz o login
    try {
      // pegar a conta (Account - Nome, Email, Foto) do google de quem fez o login
      final GoogleSignInAccount googleSignInAccount = await googleSignIn.signIn();

      // pegar dados de autenticacao (tokens para conectar com o Firebase)
      final GoogleSignInAuthentication googleSignInAuthentication = await googleSignInAccount.authentication;

      // pegar credencial
      final AuthCredential credential = GoogleAuthProvider.getCredential(
          idToken: googleSignInAuthentication.idToken,
          accessToken: googleSignInAuthentication.accessToken
      );

      // passar a credencial para o Firebase
      final AuthResult authResult = await FirebaseAuth.instance.signInWithCredential(credential);

      // pegar o usuario do Firebase
      final FirebaseUser user = authResult.user;

      return user;

    }catch (error) {
      print(error.toString());
      return null;
    }
  }

  void _sendMessage({String msg, File imgFile}) async {
    // pegar o usuario atual
    final FirebaseUser user = await _getUser();

    if (user == null) {
      _scaffoldKey.currentState.showSnackBar(
        SnackBar(
          content: Text("Não foi possivel fazer o Login. Tente novamente."),
          backgroundColor: Colors.red,
        )
      );
    }

    Map<String, dynamic> data = {
      "uid" : user.uid,
      "senderName" : user.displayName,
      "senderPhotoUrl" : user.photoUrl,
      "time" : Timestamp.now()
    };

    if (imgFile != null) {
      StorageUploadTask task = FirebaseStorage.instance.ref().child(
        DateTime.now().millisecondsSinceEpoch.toString()
      ).putFile(imgFile);

      setState(() {
        _isLoading = true;
      });

      StorageTaskSnapshot taskSnapshot = await task.onComplete;
      // Pegar Url da imagem dps de salvar
      String url = await taskSnapshot.ref.getDownloadURL();
      data["imgUrl"] = url;

      setState(() {
        _isLoading = false;
      });
    }

    if (msg != null) {
      data["text"] = msg;
    }

    Firestore.instance.collection("messages").add(data);

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: Text(_currentUser != null ? "Olá, ${_currentUser.displayName}" : "Chat App"),
        centerTitle: true,
        elevation: 0,
        actions: <Widget>[
          _currentUser != null ? IconButton(
            icon: Icon(Icons.exit_to_app),
            onPressed: (){
              FirebaseAuth.instance.signOut();
              googleSignIn.signOut();
              _scaffoldKey.currentState.showSnackBar(
                  SnackBar(
                    content: Text("Deslogado com sucesso!"),
                  )
              );
            },
          ) : IconButton(
            icon: Icon(Icons.account_circle),
            onPressed: (){
              _getUser();
            },
          )
        ],
      ),
      body: Column(
        children: <Widget>[
          Expanded(
            child: StreamBuilder<QuerySnapshot>(
              stream: Firestore.instance.collection("messages").orderBy("time").snapshots(),
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
                        var user = documents[index].data;
                          return ChatMessage(user, user["uid"] == _currentUser?.uid);
                        }
                    );
                }
              },
            ),
          ),
          _isLoading ? LinearProgressIndicator() : Container(),
          TextComposer(_sendMessage)
        ],
      ),
    );
  }
}
