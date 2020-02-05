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

  @override
  Widget build(BuildContext context) {
    return Container();
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
