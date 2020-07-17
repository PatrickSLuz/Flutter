import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:gerenciar_loja_virtual/orders/widgets/order_header.dart';

class OrderTile extends StatelessWidget {
  final DocumentSnapshot order;

  OrderTile({this.order});

  final status = [
    "",
    "Em preparação",
    "Em transporte",
    "Aguardando Entrega",
    "Entrege"
  ];

  @override
  Widget build(BuildContext context) {
    String orderId = order.documentID
        .substring(order.documentID.length - 6, order.documentID.length);
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      child: Card(
        child: ExpansionTile(
          key: Key(order.documentID),
          initiallyExpanded: order.data['status'] != 4,
          title: Text(
            "#$orderId - ${status[order.data['status']]}",
            style: TextStyle(
              color:
                  order.data['status'] != 4 ? Colors.grey[850] : Colors.green,
            ),
          ),
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 0, 16, 8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  OrderHeader(order: order),
                  Column(
                    mainAxisSize: MainAxisSize.min,
                    children: order.data['products'].map<Widget>((product) {
                      return ListTile(
                        title: Text(
                            "${product['product']['title']} - ${product['size']}"),
                        subtitle:
                            Text("${product['category']}/${product['pid']}"),
                        trailing: Text(
                          "${product['quantity']}",
                          style: TextStyle(
                            fontSize: 20,
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      FlatButton(
                        child: Text("Excluir"),
                        textColor: Colors.red,
                        onPressed: () {
                          Firestore.instance
                              .collection("users")
                              .document(order["clientId"])
                              .collection("orders")
                              .document(order.documentID)
                              .delete();
                          order.reference.delete();
                        },
                      ),
                      FlatButton(
                        child: Text("Regredir"),
                        textColor: Colors.grey[850],
                        onPressed: order.data['status'] > 1
                            ? () {
                                order.reference.updateData(
                                    {"status": order.data['status'] - 1});
                              }
                            : null,
                      ),
                      FlatButton(
                        child: Text("Avançar"),
                        textColor: Colors.green,
                        onPressed: order.data['status'] < 4
                            ? () {
                                order.reference.updateData(
                                    {"status": order.data['status'] + 1});
                              }
                            : null,
                      ),
                    ],
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
