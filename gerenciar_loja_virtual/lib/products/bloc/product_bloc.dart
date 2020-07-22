import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:rxdart/rxdart.dart';

class ProductBloc extends BlocBase {
  String categoryId;
  DocumentSnapshot product;

  ProductBloc({this.categoryId, this.product}) {
    if (product != null) {
      unsavedData = Map.of(product.data);
      unsavedData['images'] = List.of(product.data['images']);
      unsavedData['sizes'] = List.of(product.data['sizes']);
    } else {
      unsavedData = {};
    }

    _dataController.add(unsavedData);
  }

  Map<String, dynamic> unsavedData;

  final _dataController = BehaviorSubject<Map>();
  Stream<Map> get outData => _dataController.stream;

  @override
  void dispose() {
    _dataController.close();
  }
}
