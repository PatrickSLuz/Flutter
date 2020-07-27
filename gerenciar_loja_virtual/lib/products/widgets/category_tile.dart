import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:gerenciar_loja_virtual/products/view/product_edit_screen.dart';
import 'package:gerenciar_loja_virtual/products/widgets/edit_category_dialog.dart';

class CategoryTile extends StatelessWidget {
  final DocumentSnapshot category;

  CategoryTile({this.category});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      child: Card(
        child: ExpansionTile(
          title: Text(
            category.data['title'],
            style:
                TextStyle(color: Colors.grey[850], fontWeight: FontWeight.w500),
          ),
          leading: GestureDetector(
            onTap: () {
              showDialog(
                context: context,
                builder: (context) => EditCategoryDialog(category: category),
              );
            },
            child: CircleAvatar(
              backgroundColor: Colors.transparent,
              backgroundImage: NetworkImage(category.data['icon']),
            ),
          ),
          children: <Widget>[
            FutureBuilder(
              future: category.reference.collection("itens").getDocuments(),
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return Container();
                } else {
                  return Column(
                    children: snapshot.data.documents.map<Widget>((doc) {
                      return ListTile(
                        title: Text(doc.data['title']),
                        leading: CircleAvatar(
                          backgroundColor: Colors.transparent,
                          backgroundImage: NetworkImage(doc.data['images'][0]),
                        ),
                        trailing:
                            Text("R\$${doc.data['price'].toStringAsFixed(2)}"),
                        onTap: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) => ProductEditScreen(
                                categoryId: category.documentID,
                                product: doc,
                              ),
                            ),
                          );
                        },
                      );
                    }).toList()
                      ..add(
                        ListTile(
                          title: Text("Adicionar"),
                          leading: Icon(Icons.add, color: Colors.pinkAccent),
                          onTap: () {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (context) => ProductEditScreen(
                                  categoryId: category.documentID,
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                  );
                }
              },
            )
          ],
        ),
      ),
    );
  }
}
