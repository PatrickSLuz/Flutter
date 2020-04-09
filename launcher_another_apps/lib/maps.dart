import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

Widget buildLauncherMaps () {

  final String lat = "-25.4231835";
  final String lng = "-49.2695578";

  return Row(
    children: <Widget>[
      Expanded(
        child: TextField(
          keyboardType: TextInputType.text,
          enabled: false,
          decoration: InputDecoration.collapsed(
            hintText: "Abrir o Maps com Latitude e Longitude",
          ),
        ),
      ),
      IconButton(
        icon: Icon(Icons.send),
        onPressed: () async {
          /// Documentation :
          /// Google Maps in a browser: "http://maps.google.com/?q=<lat>,<lng>"
          /// Google Maps app on an iOS mobile device : "comgooglemaps://?q=<lat>,<lng>"
          /// Google Maps app on Android : "geo:<lat>,<lng>?z=<zoom>"
          /// You can also use "google.navigation:q=latitude,longitude"
          /// z is the zoom level (1-21) , q is the search query
          /// t is the map type ("m" map, "k" satellite, "h" hybrid, "p" terrain, "e" GoogleEarth)

          //final String googleMapsUrl = "geo:$lat,$lng?z=18";
          final String googleMapsUrl = "google.navigation:q=$lat,$lng";
          final String appleMapsUrl = "https://maps.apple.com/?q=$lat,$lng";

          if (await canLaunch(googleMapsUrl)) {
            await launch(googleMapsUrl);

          } else if (await canLaunch(appleMapsUrl)) {
            await launch(appleMapsUrl, forceSafariVC: false);

          } else {
            throw "Couldn't launch URL";
          }
        },
      ),
    ],
  );

}
