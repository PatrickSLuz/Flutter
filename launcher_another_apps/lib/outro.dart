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
          var browser_url = "https://www.pigbem.com";
          var app_url = "pigbem://app";

          if (await canLaunch(app_url))
            await launch(app_url);

//          else if (await canLaunch(browser_url))
//            await launch(browser_url);

          else
            throw "Couldn't launch Outro";

        },
      ),
    ],
  );
}