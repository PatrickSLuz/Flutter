import 'dart:io';
import 'package:url_launcher/url_launcher.dart';
import 'package:agenda_contatos/helpers/contact_helper.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'contact_page.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  ContactHelper helper = ContactHelper();

  List<Contact> contacts = List();

  @override
  void initState() {
    super.initState();
    _getAllContacts();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text("Contatos"),
          backgroundColor: Colors.red,
          centerTitle: true),
      backgroundColor: Colors.white,
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Novo Contato
          _showContactPage();
        },
        child: Icon(Icons.add),
        backgroundColor: Colors.red,
      ),
      body: ListView.builder(
          padding: EdgeInsets.all(10),
          itemCount: contacts.length,
          itemBuilder: (context, index) {
            return _contactCard(context, index);
          }),
    );
  }

  Widget _contactCard(BuildContext context, int index) {
    return GestureDetector(
      child: Card(
        child: Padding(
            padding: EdgeInsets.all(10),
            child: Row(
              children: <Widget>[
                Container(
                  width: 80,
                  height: 80,
                  decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      image: DecorationImage(
                          image: contacts[index].img != null
                              ? FileImage(File(contacts[index].img))
                              : AssetImage("images/default.png"))),
                ),
                Padding(
                  padding: EdgeInsets.only(left: 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(contacts[index].name ?? "",
                          style: TextStyle(
                              fontSize: 22, fontWeight: FontWeight.bold)),
                      Text(contacts[index].email ?? "",
                          style: TextStyle(fontSize: 18)),
                      Text(contacts[index].phone ?? "",
                          style: TextStyle(fontSize: 18))
                    ],
                  ),
                )
              ],
            )),
      ),
      onTap: () {
        _showOptions(context, index);
      },
    );
  }

  void _showOptions(BuildContext context, int index) {
    showModalBottomSheet(
        context: context,
        builder: (context) {
          return BottomSheet(
            onClosing: () {},
            builder: (context) {
              return Container(
                  padding: EdgeInsets.all(10),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      Padding(
                        padding: EdgeInsets.all(10),
                        child: FlatButton(
                          child: Text("Ligar",
                              style:
                                  TextStyle(color: Colors.red, fontSize: 20)),
                          onPressed: () {
                            launch("tel:${contacts[index].phone}");
                            Navigator.pop(context);
                          },
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.all(10),
                        child: FlatButton(
                          child: Text("Editar",
                              style:
                                  TextStyle(color: Colors.red, fontSize: 20)),
                          onPressed: () {
                            // Fechar a tela de opcoes
                            Navigator.pop(context);
                            // Editar Contato
                            _showContactPage(contact: contacts[index]);
                          },
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.all(10),
                        child: FlatButton(
                          child: Text("Excluir",
                              style:
                                  TextStyle(color: Colors.red, fontSize: 20)),
                          onPressed: () {
                            // Deletar Contato
                            helper.deleteContact(contacts[index].id);
                            setState(() {
                              contacts.removeAt(index);
                              // Fechar a tela de opcoes
                              Navigator.pop(context);
                            });
                          },
                        ),
                      )
                    ],
                  ));
            },
          );
        });
  }

  void _showContactPage({Contact contact}) async {
    final recContact = await Navigator.push(context,
        MaterialPageRoute(builder: (context) => ContactPage(contact: contact)));
    // Se retornou algo da tela de Novo Contato
    if (recContact != null) {
      // Se foi enviado algo para a tela
      if (contact != null) {
        await helper.updateContact(recContact);
      } else {
        // Recebeu um Contato da outra tela, mas nao foi enviado. Ou seja, eh um contato novo
        await helper.saveContact(recContact);
      }
      // Atualizar lista de contatos
      _getAllContacts();
    }
  }

  void _getAllContacts() {
    helper.getAllContact().then((list) {
      setState(() {
        contacts = list;
      });
    });
  }
}
