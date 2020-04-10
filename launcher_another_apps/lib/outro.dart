import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

Widget buildLaucherOutro () {
  return Row(
    children: <Widget>[
      Expanded(
        child: TextField(
          keyboardType: TextInputType.text,
          enabled: false,
          decoration: InputDecoration.collapsed(
            hintText: "Abrir o PigBem",
          ),
        ),
      ),
      IconButton(
        icon: Icon(Icons.send),
        onPressed: () async {
          var app_url = "pigbem://oi";

          if (await canLaunch(app_url))
            await launch(app_url);

          else
            throw "Couldn't launch Outro";

        },
      ),
    ],
  );
}