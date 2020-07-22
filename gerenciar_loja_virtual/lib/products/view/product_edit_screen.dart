import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:gerenciar_loja_virtual/products/bloc/product_bloc.dart';

class ProductEditScreen extends StatefulWidget {
  final String categoryId;
  final DocumentSnapshot product;

  ProductEditScreen({this.categoryId, this.product});

  @override
  _ProductEditScreenState createState() =>
      _ProductEditScreenState(categoryId, product);
}

class _ProductEditScreenState extends State<ProductEditScreen> {
  final _formKey = GlobalKey<FormState>();

  final ProductBloc _productBloc;

  _ProductEditScreenState(String categoryId, product)
      : _productBloc = ProductBloc(
          categoryId: categoryId,
          product: product,
        );

  @override
  Widget build(BuildContext context) {
    final _fieldStyle = TextStyle(color: Colors.white, fontSize: 16);

    InputDecoration _buildDecoration(String label) {
      return InputDecoration(
        labelText: label,
        labelStyle: TextStyle(color: Colors.grey),
      );
    }

    return Scaffold(
      backgroundColor: Colors.grey[850],
      appBar: AppBar(
        elevation: 0,
        title: Text("Criar Produto"),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.remove, color: Colors.white),
            onPressed: () {},
          ),
          IconButton(
            icon: Icon(Icons.save, color: Colors.white),
            onPressed: () {},
          ),
        ],
      ),
      body: Form(
        key: _formKey,
        child: StreamBuilder<Map>(
          stream: _productBloc.outData,
          builder: (context, snapshot) {
            if (!snapshot.hasData) return Container();
            return ListView(
              padding: const EdgeInsets.all(16),
              children: <Widget>[
                TextFormField(
                  initialValue: snapshot.data['title'],
                  style: _fieldStyle,
                  decoration: _buildDecoration("Título"),
                  onSaved: (a) {},
                  validator: (a) {},
                ),
                TextFormField(
                  initialValue: snapshot.data['description'],
                  style: _fieldStyle,
                  decoration: _buildDecoration("Descrição"),
                  maxLines: 6,
                  onSaved: (a) {},
                  validator: (a) {},
                ),
                TextFormField(
                  initialValue: snapshot.data['price']?.toStringAsFixed(2),
                  style: _fieldStyle,
                  decoration: _buildDecoration("Preço"),
                  keyboardType: TextInputType.numberWithOptions(decimal: true),
                  onSaved: (a) {},
                  validator: (a) {},
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
