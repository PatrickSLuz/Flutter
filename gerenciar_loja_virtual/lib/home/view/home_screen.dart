import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:gerenciar_loja_virtual/orders/bloc/orders_bloc.dart';
import 'package:gerenciar_loja_virtual/orders/view/orders_screen.dart';
import 'package:gerenciar_loja_virtual/products/view/products_screen.dart';
import 'package:gerenciar_loja_virtual/users/bloc/user_bloc.dart';
import 'package:gerenciar_loja_virtual/users/view/users_screen.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  PageController _pageController;
  int page = 0;

  UserBloc _userBloc;
  OrdersBloc _ordersBloc;

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
    _userBloc = UserBloc();
    _ordersBloc = OrdersBloc();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[850],
      bottomNavigationBar: Theme(
        data: Theme.of(context).copyWith(
          canvasColor: Colors.pinkAccent,
          primaryColor: Colors.white,
          textTheme: Theme.of(context).textTheme.copyWith(
                caption: TextStyle(
                  color: Colors.white54,
                ),
              ),
        ),
        child: BottomNavigationBar(
          currentIndex: page,
          onTap: (page) {
            _pageController.animateToPage(
              page,
              duration: Duration(microseconds: 600),
              curve: Curves.ease,
            );
          },
          items: [
            BottomNavigationBarItem(
              icon: Icon(Icons.person),
              title: Text("Clientes"),
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.shopping_cart),
              title: Text("Pedidos"),
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.list),
              title: Text("Produtos"),
            )
          ],
        ),
      ),
      floatingActionButton: _buildFAB(),
      body: SafeArea(
        child: BlocProvider<UserBloc>(
          bloc: _userBloc,
          child: BlocProvider<OrdersBloc>(
            bloc: _ordersBloc,
            child: PageView(
              controller: _pageController,
              onPageChanged: (value) {
                setState(() {
                  page = value;
                });
              },
              children: <Widget>[
                UsersScreen(),
                OrdersScreen(),
                ProductsScreen(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildFAB() {
    if (page == 1) {
      return SpeedDial(
        child: Icon(Icons.sort),
        backgroundColor: Colors.pinkAccent,
        overlayOpacity: 0.4,
        overlayColor: Colors.black,
        children: [
          SpeedDialChild(
            child: Icon(
              Icons.arrow_downward,
              color: Colors.pinkAccent,
            ),
            backgroundColor: Colors.white,
            label: "Concluidos abaixo",
            labelStyle: TextStyle(fontSize: 14),
            onTap: () {
              _ordersBloc.setSortType(SortType.LAST);
            },
          ),
          SpeedDialChild(
            child: Icon(
              Icons.arrow_upward,
              color: Colors.pinkAccent,
            ),
            backgroundColor: Colors.white,
            label: "Concluidos acima",
            labelStyle: TextStyle(fontSize: 14),
            onTap: () {
              _ordersBloc.setSortType(SortType.FIRST);
            },
          ),
        ],
      );
    } else {
      return null;
    }
  }
}
