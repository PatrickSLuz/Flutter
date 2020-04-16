import 'package:flutter/material.dart';

class SignUpScreen extends StatelessWidget {
  final _formkey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Criar Conta"),
        centerTitle: true,
      ),
      body: Form(
        key: _formkey,
        child: ListView(
          padding: EdgeInsets.all(16),
          children: [
            TextFormField(
              validator: (text) {
                if (text.isEmpty) return "Nome inválido";
              },
              decoration: InputDecoration(hintText: "Nome Completo"),
            ),
            SizedBox(height: 16),
            TextFormField(
              validator: (text) {
                if (text.isEmpty || !text.contains("@"))
                  return "E-mail inválido";
              },
              keyboardType: TextInputType.emailAddress,
              decoration: InputDecoration(hintText: "E-mail"),
            ),
            SizedBox(height: 16),
            TextFormField(
              validator: (text) {
                if (text.isEmpty || text.length < 6) return "Senha inválida";
              },
              obscureText: true,
              decoration: InputDecoration(hintText: "Senha"),
            ),
            SizedBox(height: 16),
            TextFormField(
              validator: (text) {
                if (text.isEmpty) return "Endereço inválido";
              },
              decoration: InputDecoration(hintText: "Endereço"),
            ),
            SizedBox(height: 16),
            SizedBox(
              height: 44,
              child: RaisedButton(
                child: Text(
                  "Criar Conta",
                  style: TextStyle(fontSize: 18),
                ),
                textColor: Colors.white,
                color: Theme.of(context).primaryColor,
                onPressed: () {
                  if (_formkey.currentState.validate()) {}
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
