import 'package:animations/login/widgets/input_field.dart';
import 'package:flutter/material.dart';

class FormContainer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20),
      child: Form(
        child: Column(
          children: <Widget>[
            InputField(
              icon: Icons.person_outline,
              hint: "Username",
              obscure: false,
            ),
            InputField(
              icon: Icons.lock_outline,
              hint: "Password",
              obscure: true,
            ),
          ],
        ),
      ),
    );
  }
}
