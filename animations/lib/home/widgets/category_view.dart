import 'package:flutter/material.dart';

class CategoryView extends StatefulWidget {
  @override
  _CategoryViewState createState() => _CategoryViewState();
}

class _CategoryViewState extends State<CategoryView> {
  final List<String> categories = ["TRABALHO", "CURSOS", "OUTROS"];
  int categoryIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        IconButton(
          icon: Icon(Icons.arrow_back_ios),
          color: Colors.white,
          disabledColor: Colors.white60,
          onPressed: categoryIndex > 0 ? selectBackward : null,
        ),
        Text(
          categories[categoryIndex],
          style: TextStyle(
            letterSpacing: 1.2,
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 18,
          ),
        ),
        IconButton(
          icon: Icon(Icons.arrow_forward_ios),
          color: Colors.white,
          disabledColor: Colors.white30,
          onPressed:
              categoryIndex < (categories.length - 1) ? selectForward : null,
        )
      ],
    );
  }

  void selectForward() {
    setState(() {
      categoryIndex++;
    });
  }

  void selectBackward() {
    setState(() {
      categoryIndex--;
    });
  }
}
