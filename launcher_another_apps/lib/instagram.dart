import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

Widget buildLaucherInstagram () {
  return Row(
    children: <Widget>[
      Expanded(
        child: TextField(
          keyboardType: TextInputType.text,
          enabled: false,
          decoration: InputDecoration.collapsed(
            hintText: "Abrir o Instagram",
          ),
        ),
      ),
      IconButton(
        icon: Icon(Icons.send),
        onPressed: () async {

          /// instagram://app - Inicia o aplicativo do Instagram.
          /// instagram://profile - Inicia o aplicativo do Instagram no perfil logado.
          /// instagram://camera - Inicia o aplicativo do Instagram com a visualização de câmera ou a biblioteca de fotos em dispositivos sem câmera.
          /// instagram://media?id= - Inicia o aplicativo do Instagram e carrega a publicação que corresponde ao valor do ID fornecido (int).
          /// instagram://user?username= - Inicia o aplicativo do Instagram e carrega o usuário do Instagram que corresponde ao valor de nome de usuário fornecido (string).
          /// instagram://location?id= - Inicia o aplicativo do Instagram e carrega o feed de localização que corresponde ao valor do ID fornecido (int).
          /// instagram://tag?name= - Inicia o aplicativo do Instagram e carrega a página da hashtag que corresponde ao valor do nome fornecido (string).

          var profile = "";
          var browser_url = "https://www.instagram.com/$profile/?hl=pt-br";
          var app_url = "instagram://user?username=$profile";


          if (await canLaunch(app_url))
            await launch(app_url);

          else if (await canLaunch(browser_url))
            await launch(browser_url);

          else
            throw "Couldn't launch Instagram";


        },
      ),
    ],
  );
}