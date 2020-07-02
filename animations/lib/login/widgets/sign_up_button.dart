import 'package:flutter/material.dart';

class SignUpButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FlatButton(
      padding: const EdgeInsets.only(top: 160),
      onPressed: () {},
      child: Text(
        "Não possui uma conta? Cadastre-se!",
        textAlign: TextAlign.center,
        overflow: TextOverflow.ellipsis,
        style: TextStyle(
          color: Colors.white,
          fontSize: 12,
          letterSpacing: 0.5,
        ),
      ),
    );
  }
}
