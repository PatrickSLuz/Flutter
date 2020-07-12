import 'package:flutter/material.dart';
import 'package:gerenciar_loja_virtual/home/view/home_screen.dart';
import 'package:gerenciar_loja_virtual/login/bloc/login_bloc.dart';
import 'package:gerenciar_loja_virtual/login/widgets/input_field.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _loginBloc = LoginBloc();

  @override
  void initState() {
    super.initState();

    _loginBloc.outState.listen((state) {
      switch (state) {
        case LoginState.SUCCESS:
          Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (_) => HomeScreen()),
          );
          break;
        case LoginState.FAIL:
          showDialog(
            context: context,
            builder: (context) => AlertDialog(
              title: Text("Erro"),
              content:
                  Text("Este usuário não possui os privilégios necessários!"),
            ),
          );
          break;
        case LoginState.LOADING:
        case LoginState.IDLE:
      }
    });
  }

  @override
  void dispose() {
    _loginBloc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[850],
      body: StreamBuilder<LoginState>(
        stream: _loginBloc.outState,
        builder: (context, snapshot) {
          switch (snapshot.data) {
            case LoginState.LOADING:
              return Center(
                  child: CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation(Colors.pinkAccent),
              ));
            case LoginState.IDLE:
            case LoginState.FAIL:
            case LoginState.SUCCESS:
            default:
              return Stack(
                alignment: Alignment.center,
                children: <Widget>[
                  Container(),
                  SingleChildScrollView(
                    child: Container(
                      margin: const EdgeInsets.symmetric(horizontal: 16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: <Widget>[
                          Icon(
                            Icons.store,
                            size: 160,
                            color: Colors.pinkAccent,
                          ),
                          InputField(
                            icon: Icons.person_outline,
                            hint: "Usuário",
                            obscure: false,
                            stream: _loginBloc.outEmail,
                            onChanged: _loginBloc.changeEmail,
                          ),
                          SizedBox(height: 15),
                          InputField(
                            icon: Icons.lock,
                            hint: "Senha",
                            obscure: true,
                            stream: _loginBloc.outPassword,
                            onChanged: _loginBloc.changePassword,
                          ),
                          SizedBox(height: 30),
                          StreamBuilder<bool>(
                            stream: _loginBloc.outSubmitValid,
                            builder: (context, snapshot) {
                              return RaisedButton(
                                child: Container(
                                  padding:
                                      const EdgeInsets.fromLTRB(0, 15, 0, 15),
                                  child: Text("Entrar"),
                                ),
                                textColor: Colors.white,
                                disabledColor: Colors.pinkAccent.withAlpha(120),
                                color: Colors.pinkAccent,
                                onPressed:
                                    snapshot.hasData ? _loginBloc.submit : null,
                              );
                            },
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              );
          }
        },
      ),
    );
  }
}
