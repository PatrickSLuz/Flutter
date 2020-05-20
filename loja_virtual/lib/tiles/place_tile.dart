import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class PlaceTile extends StatelessWidget {
  final DocumentSnapshot snapshot;

  PlaceTile(this.snapshot);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          SizedBox(
            height: 100,
            child: Image.network(
              snapshot.data['image'],
              fit: BoxFit.cover,
            ),
          ),
          Container(
            padding: const EdgeInsets.all(8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  snapshot.data['title'],
                  textAlign: TextAlign.start,
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17),
                ),
                Text(
                  snapshot.data['address'],
                  textAlign: TextAlign.start,
                ),
              ],
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              FlatButton(
                child: Text("Ver no Mapa"),
                textColor: Colors.blue,
                padding: EdgeInsets.zero,
                onPressed: () {
                  String lat = snapshot.data['lat'];
                  String long = snapshot.data['long'];
                  String url =
                      "https://www.google.com/maps/search/?api=1&query=$lat,$long";
                  launch(url);
                },
              ),
              FlatButton(
                child: Text("Ligar"),
                textColor: Colors.blue,
                padding: EdgeInsets.zero,
                onPressed: () {
                  launch("tel:${snapshot.data['phone']}");
                },
              )
            ],
          )
        ],
      ),
    );
  }
}
