import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:rxdart/rxdart.dart';

class ProductBloc extends BlocBase {
  String categoryId;
  DocumentSnapshot product;

  ProductBloc({this.categoryId, this.product}) {
    if (product != null) {
      unsavedData = Map.of(product.data);
      unsavedData['images'] = List.of(product.data['images'] ?? []);
      unsavedData['sizes'] = List.of(product.data['sizes'] ?? []);

      _createdController.add(true);
    } else {
      unsavedData = {};
      _createdController.add(false);
    }

    _dataController.add(unsavedData);
  }

  Map<String, dynamic> unsavedData;

  final _dataController = BehaviorSubject<Map>();
  Stream<Map> get outData => _dataController.stream;

  final _loadingController = BehaviorSubject<bool>();
  Stream<bool> get outLoading => _loadingController.stream;

  final _createdController = BehaviorSubject<bool>();
  Stream<bool> get outCreated => _createdController.stream;

  void saveImages(List images) {
    unsavedData['images'] = images;
  }

  void saveTitle(String title) {
    unsavedData['title'] = title;
  }

  void saveDescription(String description) {
    unsavedData['description'] = description;
  }

  void savePrice(String price) {
    unsavedData['price'] = double.parse(price);
  }

  void saveSizes(List sizes) {
    unsavedData['sizes'] = sizes;
  }

  Future<bool> saveProduct() async {
    _loadingController.add(true);
    try {
      if (product != null) {
        // editar produto
        await _uploadImages(product.documentID);
        await product.reference.updateData(unsavedData);
      } else {
        // novo produto
        // salvando primeiramente sem as imagens,
        // pois para salvar as imgs precisa do id do produto
        DocumentReference documentReference = await Firestore.instance
            .collection("products")
            .document(categoryId)
            .collection("itens")
            .add(Map.from(unsavedData)..remove('images'));
        // Map.from() = utilizar uma copia do obj

        // salvar as imagens com o id do produto
        await _uploadImages(documentReference.documentID);

        // salvar o produto com as imagens
        documentReference.updateData(unsavedData);
      }

      _createdController.add(true);
      _loadingController.add(false);
      return true;
    } catch (error) {
      _loadingController.add(false);
      return false;
    }
  }

  Future _uploadImages(String productId) async {
    for (int i = 0; i < unsavedData['images'].length; i++) {
      // verifica se é string
      // se for string ja esta no firebase
      // pq é uma url
      if (unsavedData['images'][i] is String) continue;

      // se nao faz o upload no storage do firebase
      StorageUploadTask uploadTask = FirebaseStorage.instance
          .ref()
          .child(categoryId)
          .child(productId)
          .child(DateTime.now().millisecondsSinceEpoch.toString())
          .putFile(unsavedData['images'][i]);

      StorageTaskSnapshot storageTaskSnapshot = await uploadTask.onComplete;

      String downloadUrl = await storageTaskSnapshot.ref.getDownloadURL();

      unsavedData['images'][i] = downloadUrl;
    }
  }

  void deleteProduct() {
    product.reference.delete();
  }

  @override
  void dispose() {
    _dataController.close();
    _loadingController.close();
    _createdController.close();
  }
}
