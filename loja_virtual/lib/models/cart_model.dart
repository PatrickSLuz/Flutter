import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:loja_virtual/datas/cart_product.dart';
import 'package:loja_virtual/models/user_model.dart';
import 'package:scoped_model/scoped_model.dart';

class CartModel extends Model {
  UserModel user;
  bool isLoading = false;
  List<CartProduct> products = [];
  String couponCode;
  int discountPercentage = 0;

  CartModel(this.user) {
    if (user.isLoggedIn()) {
      _loadCartItens();
    }
  }

  static CartModel of(BuildContext context) =>
      ScopedModel.of<CartModel>(context);

  void addCartItem(CartProduct cartProduct) {
    products.add(cartProduct);
    Firestore.instance
        .collection("users")
        .document(user.firebaseUser.uid)
        .collection("cart")
        .add(cartProduct.toMap())
        .then((doc) {
      cartProduct.cid = doc.documentID;

      notifyListeners();
    });
  }

  void removeCartIten(CartProduct cartProduct) {
    Firestore.instance
        .collection("users")
        .document(user.firebaseUser.uid)
        .collection("cart")
        .document(cartProduct.cid)
        .delete();
    products.remove(cartProduct);
  }

  void decProduct(CartProduct cartProduct) {
    cartProduct.quantity--;
    Firestore.instance
        .collection("users")
        .document(user.firebaseUser.uid)
        .collection("cart")
        .document(cartProduct.cid)
        .updateData(cartProduct.toMap());
  }

  void incProduct(CartProduct cartProduct) {
    cartProduct.quantity++;
    Firestore.instance
        .collection("users")
        .document(user.firebaseUser.uid)
        .collection("cart")
        .document(cartProduct.cid)
        .updateData(cartProduct.toMap());
  }

  void setCoupon(String couponCode, int discountPercentage) {
    this.couponCode = couponCode;
    this.discountPercentage = discountPercentage;
  }

  void _loadCartItens() async {
    QuerySnapshot query = await Firestore.instance
        .collection("users")
        .document(user.firebaseUser.uid)
        .collection("cart")
        .getDocuments();

    products =
        query.documents.map((doc) => CartProduct.fromDocument(doc)).toList();
    notifyListeners();
  }
}
