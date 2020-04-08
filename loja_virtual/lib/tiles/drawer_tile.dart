import 'package:flutter/material.dart';

class DrawerTile extends StatelessWidget {

  final IconData icon;
  final String text;

  DrawerTile(this.icon, this.text);

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        child: Container(
          height: 60,
          child: Row(
            children: <Widget>[
              Icon(
                icon,
                size: 32,
                color: Colors.blue,
              ),
              SizedBox(width: 32,),
              Text(
                text,
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.blue
                ),
              ),
            ],
          ),
        ),
        onTap: () {
          
        },
      ),
    );
  }
}
