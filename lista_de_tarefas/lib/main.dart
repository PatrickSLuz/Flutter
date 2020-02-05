import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';

void main() {
  runApp(
    MaterialApp(
      home: Home(),
    ),
  );
}

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List _tarefasList = [];

  final _tarefaController = TextEditingController();

  @override
  // funcao que eh chamado sempre que a tela do app eh aberta
  void initState() {
    super.initState();
    _readData().then((data) {
      setState(() {
        _tarefasList = json.decode(data);
      });
    });
  }

  void _addTarefa() {
    setState(() {
      Map<String, dynamic> newTarefa = Map();
      newTarefa["title"] = _tarefaController.text;
      _tarefaController.text = "";
      newTarefa["ok"] = false;
      _tarefasList.add(newTarefa);
      _saveData();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Lista de Tarefas"),
        backgroundColor: Colors.blueAccent,
        centerTitle: true,
      ),
      body: Column(
        children: <Widget>[
          Container(
            padding: EdgeInsets.fromLTRB(17, 1, 7, 1),
            child: Row(
              children: <Widget>[
                Expanded(
                  child: TextField(
                    controller: _tarefaController,
                    decoration: InputDecoration(
                        labelText: "Nova Tarefa",
                        labelStyle: TextStyle(color: Colors.blueAccent)),
                  ),
                ),
                RaisedButton(
                  color: Colors.blueAccent,
                  child: Text("Add"),
                  textColor: Colors.white,
                  onPressed: _addTarefa,
                )
              ],
            ),
          ),
          Expanded(
            child: ListView.builder(
              padding: EdgeInsets.only(top: 10),
              itemCount: _tarefasList.length,
              itemBuilder: buildItem, // itemBuilder
            ),
          )
        ],
      ),
    );
  }

  Widget buildItem(context, index) {
    return Dismissible(
      // permite arrastar um item para a direita, para deleta-lo
      key: Key(DateTime.now().millisecondsSinceEpoch.toString()),
      background: Container(
          color: Colors.red,
          child: Align(
            alignment: Alignment(-0.9, 0),
            child: Icon(Icons.delete, color: Colors.white),
          )),
      direction: DismissDirection.startToEnd,
      child: CheckboxListTile(
        title: Text(_tarefasList[index]["title"]),
        value: _tarefasList[index]["ok"],
        secondary: CircleAvatar(
          child: Icon(_tarefasList[index]["ok"] ? Icons.check : Icons.error),
        ),
        onChanged: (checked) {
          setState(() {
            _tarefasList[index]["ok"] = checked;
            _saveData();
          });
        },
      ),
    );
  }

  // Pegar diretorio do arquivo
  Future<File> _getFile() async {
    // Pega o diretorio onde eh possivel armazenar os arquivos do app
    final directory = await getApplicationDocumentsDirectory();
    return File("${directory.path}/data_tarefas.json");
  }

  // Salvar dados no arquivo
  Future<File> _saveData() async {
    // transformando a lista em JSON e armazenando em uma String
    String data = json.encode(_tarefasList);
    final file = await _getFile();
    return file.writeAsString(data);
  }

  // Ler dados gravados no arquivo
  Future<String> _readData() async {
    try {
      final file = await _getFile();
      return file.readAsString();
    } catch (e) {
      return null;
    }
  }
}
