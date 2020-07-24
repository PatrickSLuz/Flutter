import 'package:flutter/material.dart';

class AddSizeDialog extends StatelessWidget {
  final _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Container(
        padding: const EdgeInsets.fromLTRB(8, 8, 8, 0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            TextField(
              controller: _controller,
              decoration: InputDecoration(hintText: "Tamanho"),
              textCapitalization: TextCapitalization.characters,
            ),
            Container(
              alignment: Alignment.centerRight,
              child: FlatButton(
                child: Text("Adicionar"),
                textColor: Colors.pinkAccent,
                onPressed: () {
                  // navigator pop com parametro
                  Navigator.of(context).pop(_controller.text);
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
