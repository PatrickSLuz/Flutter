import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

Widget buildLaucherFacebook () {
  return Row(
    children: <Widget>[
      Expanded(
        child: TextField(
          keyboardType: TextInputType.text,
          enabled: false,
          decoration: InputDecoration.collapsed(
            hintText: "Abrir o Facebook",
          ),
        ),
      ),
      IconButton(
        icon: Icon(Icons.send),
        onPressed: () async {
          var id = "118009792184191"; // https://findmyfbid.com/
          var profile = "pigbem";
          var browser_url = "https://fb.me/$profile";
          var messenger_url = "https://m.me/$profile";
          var app_page_url = "fb://page/$id"; // Pagina
          var app_profile_url = "fb://profile/$id"; // Pagina

          if (await canLaunch(app_page_url))
            await launch(app_page_url);

          else if (await canLaunch(browser_url))
            await launch(browser_url);

          else
            throw "Couldn't launch Facebook";

        },
      ),
    ],
  );
}