import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:gerenciar_loja_virtual/products/bloc/product_bloc.dart';
import 'package:gerenciar_loja_virtual/products/validators/product_validator.dart';
import 'package:gerenciar_loja_virtual/products/widgets/image_widget.dart';
import 'package:gerenciar_loja_virtual/products/widgets/product_sizes.dart';

class ProductEditScreen extends StatefulWidget {
  final String categoryId;
  final DocumentSnapshot product;

  ProductEditScreen({this.categoryId, this.product});

  @override
  _ProductEditScreenState createState() =>
      _ProductEditScreenState(categoryId, product);
}

class _ProductEditScreenState extends State<ProductEditScreen>
    with ProductValidator {
  final _formKey = GlobalKey<FormState>();
  final _scaffoldKey = GlobalKey<ScaffoldState>();

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
      key: _scaffoldKey,
      backgroundColor: Colors.grey[850],
      appBar: AppBar(
        elevation: 0,
        title: StreamBuilder<bool>(
          stream: _productBloc.outCreated,
          initialData: false,
          builder: (context, snapshot) {
            return Text(snapshot.data ? "Editar produto" : "Criar Produto");
          },
        ),
        actions: <Widget>[
          StreamBuilder<bool>(
            stream: _productBloc.outCreated,
            initialData: false,
            builder: (context, snapshot) {
              if (snapshot.data) {
                return StreamBuilder<bool>(
                  stream: _productBloc.outLoading,
                  initialData: false,
                  builder: (context, snapshot) {
                    return IconButton(
                      icon: Icon(Icons.remove),
                      color: Colors.white,
                      onPressed: snapshot.data
                          ? null
                          : () {
                              _productBloc.deleteProduct();
                              Navigator.of(context).pop();
                            },
                    );
                  },
                );
              } else {
                return Container();
              }
            },
          ),
          StreamBuilder<bool>(
            stream: _productBloc.outLoading,
            initialData: false,
            builder: (context, snapshot) {
              return IconButton(
                icon: Icon(Icons.save),
                color: Colors.white,
                onPressed: snapshot.data ? null : saveProduct,
              );
            },
          ),
        ],
      ),
      body: Stack(
        children: <Widget>[
          Form(
            key: _formKey,
            child: StreamBuilder<Map>(
              stream: _productBloc.outData,
              builder: (context, snapshot) {
                if (!snapshot.hasData) return Container();
                return ListView(
                  padding: const EdgeInsets.all(16),
                  children: <Widget>[
                    Text(
                      "Imagens",
                      style: TextStyle(
                        color: Colors.grey,
                        fontSize: 12,
                      ),
                    ),
                    ImagesWidget(
                      context: context,
                      initialValue: snapshot.data['images'] ?? [],
                      onSaved: _productBloc.saveImages,
                      validator: validateImages,
                    ),
                    TextFormField(
                      initialValue: snapshot.data['title'],
                      style: _fieldStyle,
                      decoration: _buildDecoration("Título"),
                      onSaved: _productBloc.saveTitle,
                      validator: validateTitle,
                    ),
                    TextFormField(
                      initialValue: snapshot.data['description'],
                      style: _fieldStyle,
                      decoration: _buildDecoration("Descrição"),
                      maxLines: 6,
                      onSaved: _productBloc.saveDescription,
                      validator: validateDescription,
                    ),
                    TextFormField(
                      initialValue: snapshot.data['price']?.toStringAsFixed(2),
                      style: _fieldStyle,
                      decoration: _buildDecoration("Preço"),
                      keyboardType:
                          TextInputType.numberWithOptions(decimal: true),
                      onSaved: _productBloc.savePrice,
                      validator: validatePrice,
                    ),
                    SizedBox(height: 16),
                    Text(
                      "Tamanhos",
                      style: TextStyle(
                        color: Colors.grey,
                        fontSize: 12,
                      ),
                    ),
                    ProductSizes(
                      context: context,
                      initialValue: snapshot.data['sizes'] ?? [],
                      onSaved: _productBloc.saveSizes,
                      validator: (value) {
                        if (value.isEmpty) return "";
                        return null;
                      },
                    )
                  ],
                );
              },
            ),
          ),
          StreamBuilder(
            stream: _productBloc.outLoading,
            initialData: false,
            builder: (context, snapshot) {
              return IgnorePointer(
                ignoring: !snapshot.data,
                child: Container(
                  color: snapshot.data ? Colors.black54 : Colors.transparent,
                ),
              );
            },
          )
        ],
      ),
    );
  }

  void saveProduct() async {
    if (_formKey.currentState.validate()) {
      _formKey.currentState.save();

      _scaffoldKey.currentState.showSnackBar(
        SnackBar(
          backgroundColor: Colors.pinkAccent,
          content: Text(
            "Salvando Produto...",
            style: TextStyle(color: Colors.white),
          ),
          duration: Duration(minutes: 1),
        ),
      );

      bool success = await _productBloc.saveProduct();

      _scaffoldKey.currentState.removeCurrentSnackBar();

      _scaffoldKey.currentState.showSnackBar(
        SnackBar(
          backgroundColor: Colors.pinkAccent,
          content: Text(
            success
                ? "Produto Salvo com sucesso!"
                : "Erro ao salvar o Produto!",
            style: TextStyle(color: Colors.white),
          ),
        ),
      );
    }
  }
}
