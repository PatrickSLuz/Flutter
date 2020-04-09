import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

Widget buildLauncherPhone (_phoneController) {
  return Row(
    children: <Widget>[
      Expanded(
        child: TextField(
          controller: _phoneController,
          keyboardType: TextInputType.number,
          decoration: InputDecoration.collapsed(
            hintText: "Fazer uma ligação",
          ),
        ),
      ),
      IconButton(
        icon: Icon(Icons.send),
        onPressed: () async {
          var url = "tel://" + _phoneController.text;

          if (await canLaunch(url)){
            await launch(url);
          } else {
          throw "Couldn't launch Phone";
          }

        },
      ),
    ],
  );
}