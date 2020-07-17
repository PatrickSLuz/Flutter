import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:rxdart/rxdart.dart';

enum SortType { FIRST, LAST }

class OrdersBloc extends BlocBase {
  Firestore _firestore = Firestore.instance;

  List<DocumentSnapshot> _orders = [];

  SortType _sortType;

  final _ordersController = BehaviorSubject<List>();
  Stream<List> get outOrders => _ordersController.stream;

  OrdersBloc() {
    _addOrdersListener();
  }

  void _addOrdersListener() {
    _firestore.collection("orders").snapshots().listen((snapshot) {
      snapshot.documentChanges.forEach((change) {
        String oid = change.document.documentID;
        switch (change.type) {
          case DocumentChangeType.added:
            _orders.add(change.document);
            break;
          case DocumentChangeType.modified:
            _orders.removeWhere((order) => order.documentID == oid);
            _orders.add(change.document);
            break;
          case DocumentChangeType.removed:
            _orders.removeWhere((order) => order.documentID == oid);
            break;
        }
      });
      _sort();
    });
  }

  void setSortType(SortType sortType) {
    _sortType = sortType;
    _sort();
  }

  void _sort() {
    switch (_sortType) {
      case SortType.FIRST:
        _orders.sort((a, b) {
          int sa = a.data['status'];
          int sb = b.data['status'];
          if (sa < sb)
            return 1;
          else if (sa > sb)
            return -1;
          else
            return 0;
        });
        break;
      case SortType.LAST:
        _orders.sort((a, b) {
          int sa = a.data['status'];
          int sb = b.data['status'];
          if (sa > sb)
            return 1;
          else if (sa < sb)
            return -1;
          else
            return 0;
        });
        break;
    }
    _ordersController.add(_orders);
  }

  @override
  void dispose() {
    _ordersController.close();
  }
}
