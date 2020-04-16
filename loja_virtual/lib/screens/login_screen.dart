import 'package:flutter/material.dart';

class LoginScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Entrar"),
        centerTitle: true,
        actions: [
          FlatButton(
            child: Text(
              "CRIAR CONTA",
              style: TextStyle(
                fontSize: 15
              ),
            ),
            textColor: Colors.white,
            onPressed: () {

            },
          )
        ],
      ),
      body: Form(
        child: ListView(
          padding: EdgeInsets.all(16),
          children: [
            TextFormField(
              keyboardType: TextInputType.emailAddress,
              decoration: InputDecoration(
                hintText: "E-mail"
              ),
            ),
            SizedBox(height: 16),
            TextFormField(
              obscureText: true,
              decoration: InputDecoration(
                hintText: "Senha"
              ),
            ),
            Align(
              alignment: Alignment.centerRight,
              child: FlatButton(
                padding: EdgeInsets.zero,
                child: Text(
                  "Esqueci minha Senha",
                  textAlign: TextAlign.center,
                ),
              ),
            ),
            SizedBox(height: 16),
            RaisedButton(
              child: Text(
                "Entrar",
                style: TextStyle(
                  fontSize: 18
                ),
              ),
              textColor: Colors.white,
              color: Theme.of(context).primaryColor,
            )
          ],
        ),
      ),
    );
  }
}