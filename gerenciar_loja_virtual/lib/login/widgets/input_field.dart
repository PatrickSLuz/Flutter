import 'package:flutter/material.dart';

class InputField extends StatelessWidget {
  final IconData icon;
  final String hint;
  final bool obscure;
  final Stream<String> stream;
  final Function(String) onChanged;

  InputField({this.icon, this.hint, this.obscure, this.stream, this.onChanged});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<String>(
      stream: stream,
      builder: (context, snapshot) {
        return TextField(
          onChanged: onChanged,
          decoration: InputDecoration(
            icon: Icon(icon, color: Colors.white),
            hintText: hint,
            hintStyle: TextStyle(color: Colors.white),
            errorText: snapshot.hasError ? snapshot.error : null,
            focusedBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: Colors.pinkAccent),
            ),
          ),
          style: TextStyle(color: Colors.white),
          obscureText: obscure,
        );
      },
    );
  }
}
