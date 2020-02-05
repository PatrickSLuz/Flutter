import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:async/async.dart';
import 'dart:convert';

const request_url = "https://api.hgbrasil.com/finance?key=b756e362";

void main() async{

  http.Response response = await http.get(request_url);
  print(json.decode(response.body)["results"]["currencies"]);

  runApp(MaterialApp(
    home: Container(),
  ));
}
