import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:gerenciar_loja_virtual/users/bloc/user_bloc.dart';

class OrderHeader extends StatelessWidget {
  final DocumentSnapshot order;

  OrderHeader({this.order});

  @override
  Widget build(BuildContext context) {
    final _userBloc = BlocProvider.of<UserBloc>(context);
    final _user = _userBloc.getUser(order.data['clientId']);

    return Row(
      children: <Widget>[
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text("${_user['name']}"),
              Text("${_user['address']}"),
            ],
          ),
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: <Widget>[
            Text(
              "Produtos: R\$${order['productsPrice'].toStringAsFixed(2)}",
              style: TextStyle(
                fontWeight: FontWeight.w500,
                fontSize: 13,
              ),
            ),
            order['discount'] > 0
                ? Text(
                    "Desconto: R\$${order['discount'].toStringAsFixed(2)}",
                    style: TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 12,
                    ),
                  )
                : Container(),
            Text(
              "Entrega: R\$${order['shipPrice'].toStringAsFixed(2)}",
              style: TextStyle(
                fontWeight: FontWeight.w500,
                fontSize: 12,
              ),
            ),
            Text(
              "Total: R\$${order['totalPrice'].toStringAsFixed(2)}",
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
