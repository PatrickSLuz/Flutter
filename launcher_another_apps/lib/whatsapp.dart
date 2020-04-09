import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

Widget buildLaucherWhatsApp (_whatsController) {
  return Row(
    children: <Widget>[
      Expanded(
        child: TextField(
          controller: _whatsController,
          keyboardType: TextInputType.text,
          decoration: InputDecoration.collapsed(
            hintText: "Msg no WhatsApp",
          ),
        ),
      ),
      IconButton(
        icon: Icon(Icons.send),
        onPressed: () async {
          //launch("whatsapp://send?phone=5541988356904&text=" + _whatsController.text); // abre direto na conversa com a msg
          var url = "whatsapp://send?text=" + _whatsController.text; // selecionar pra quem vai mandar. dps de selecionado ja vem com a msg

          if (await canLaunch(url)){
            await launch(url);
          } else {
            throw "Couldn't launch WhatsApp";
          }

        },
      ),
    ],
  );
}