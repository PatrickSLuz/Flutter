import 'package:flutter/material.dart';
import 'package:launcher_another_apps/browser.dart';
import 'package:launcher_another_apps/facebook.dart';
import 'package:launcher_another_apps/instagram.dart';
import 'package:launcher_another_apps/maps.dart';
import 'package:launcher_another_apps/outro.dart';
import 'package:launcher_another_apps/phone.dart';
import 'package:launcher_another_apps/whatsapp.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Laucher Another Apps',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      debugShowCheckedModeBanner: false,
      home: HomeScreen(),
    );
  }
}

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  final TextEditingController _siteController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _whatsController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Laucher Another Apps"),
        centerTitle: true,
      ),
      body: Container(
        margin: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: <Widget>[
            buildLauncherBrowser(_siteController),
            buildLauncherPhone(_phoneController),
            buildLaucherWhatsApp(_whatsController),
            buildLaucherFacebook(),
            buildLaucherInstagram(),
            buildLaucherOutro(),
            buildLauncherMaps()
          ],
        ),
      ),
    );
  }
}

