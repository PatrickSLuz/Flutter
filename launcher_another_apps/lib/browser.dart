import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

Widget buildLauncherBrowser (_siteController) {
  return Row(
    children: <Widget>[
      Expanded(
        child: TextField(
          controller: _siteController,
          keyboardType: TextInputType.text,
          decoration: InputDecoration.collapsed(
            hintText: "Acessar um Site",
          ),
        ),
      ),
      IconButton(
        icon: Icon(Icons.send),
        onPressed: () async {
          var url = "https://" + _siteController.text;

          // Abrir a pagina como WebView dentro do proprio app
          // Usar forceWebView: true
          // Ex: await launch(url, forceWebView: true);

          if (await canLaunch(url) && Platform.isAndroid) {
            await launch(url, forceSafariVC: false);

          } else if (await canLaunch(url) && Platform.isIOS) {
            await launch(url, forceSafariVC: true);

          } else {
            throw 'Could not launch $url';
          }

        },
      ),
    ],
  );
}