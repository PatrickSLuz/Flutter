import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(title: "Contatdo de Pessoas", home: Home()));
}

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int _people = 0;
  String _infoText = "Pode Entrar!";

  void _chagePeople(int delta) {
    setState(() {
      _people += delta;
      
      if(_people < 0){
        _infoText = "Ueh??";
      }else if (_people <= 10){
        _infoText = "Pode Entrar!";
      }else{
        _infoText = "Lotado!";
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Image.asset(
          "Image/restaurant.jpg",
          fit: BoxFit.cover,
          height: 1000,
        ),
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text("Pessoas: $_people",
                style: TextStyle(
                    color: Colors.white, fontWeight: FontWeight.bold)),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.all(10),
                  child: FlatButton(
                    child: Text("+1",
                        style: TextStyle(fontSize: 40, color: Colors.white)),
                    onPressed: () {
                      _chagePeople(1);
                    },
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(10),
                  child: FlatButton(
                    child: Text("-1",
                        style: TextStyle(fontSize: 40, color: Colors.white)),
                    onPressed: () {
                      _chagePeople(-1);
                    },
                  ),
                ),
              ],
            ),
            Text(_infoText,
                style: TextStyle(
                    color: Colors.white,
                    fontStyle: FontStyle.italic,
                    fontSize: 30))
          ],
        )
      ],
    );
  }
}
