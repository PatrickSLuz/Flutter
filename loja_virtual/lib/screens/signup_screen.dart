import 'package:flutter/material.dart';
import 'package:loja_virtual/models/user_model.dart';
import 'package:scoped_model/scoped_model.dart';

class SignUpScreen extends StatefulWidget {
  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
 final _formkey = GlobalKey<FormState>();

  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passController = TextEditingController();
  final _addressController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Criar Conta"),
        centerTitle: true,
      ),
      body: ScopedModelDescendant<UserModel>(
        builder: (context, child, model) {
          if(model.isLoading)
            return Center(child: CircularProgressIndicator());

          return Form(
            key: _formkey,
            child: ListView(
              padding: EdgeInsets.all(16),
              children: [
                TextFormField(
                  controller: _nameController,
                  validator: (text) {
                    if (text.isEmpty) return "Nome inválido";
                  },
                  decoration: InputDecoration(hintText: "Nome Completo"),
                ),
                SizedBox(height: 16),
                TextFormField(
                  controller: _emailController,
                  validator: (text) {
                    if (text.isEmpty || !text.contains("@"))
                      return "E-mail inválido";
                  },
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecoration(hintText: "E-mail"),
                ),
                SizedBox(height: 16),
                TextFormField(
                  controller: _passController,
                  validator: (text) {
                    if (text.isEmpty || text.length < 6) return "Senha inválida";
                  },
                  obscureText: true,
                  decoration: InputDecoration(hintText: "Senha"),
                ),
                SizedBox(height: 16),
                TextFormField(
                  controller: _addressController,
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
                      if (_formkey.currentState.validate()) {

                        Map<String, dynamic> userData = {
                          "name":_nameController.text,
                          "email":_emailController.text,
                          "address":_addressController.text
                        };
                        model.singUp(
                          userData: userData, 
                          pass: _passController.text, 
                          onSuccess: _onSuccess, 
                          onFail: _onFail
                        );
                      }
                    },
                  ),
                )
              ],
            ),
          );
        },
      ),
    );
  }

  void _onSuccess() {

  }

  void _onFail() {
    
  }

}
