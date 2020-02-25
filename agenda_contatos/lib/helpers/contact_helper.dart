import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

// Nome da Tabela e das Colunas do Banco de Dados
final String contactTable = "contactTable";
final String idColumn = "idColumn";
final String nameColumn = "nameColumn";
final String emailColumn = "emailColumn";
final String phoneColumn = "phoneColumn";
final String imgColumn = "imgColumn";

class ContactHelper {
  // Classe Singleton
  static final ContactHelper _instance = ContactHelper.internal();

  factory ContactHelper() => _instance;

  ContactHelper.internal();

  // Banco de Dados
  Database _db;

// Inicializar o Banco de Dados
  Future<Database> get db async {
    if (_db != null) {
      return _db;
    } else {
      _db = await initDb();
      return _db;
    }
  }

  Future<Database> initDb() async {
    // Pegar o caminho do BD
    final databasePath = await getDatabasesPath();
    // Arquivo
    final path = join(databasePath, "contacts.db");
    // Abrir o BD
    return await openDatabase(path, version: 1,
        onCreate: (Database db, int newerVersion) async {
      await db.execute(
          "CREATE TABLE $contactTable ($idColumn INTEGER PRIMARY KEY, $nameColumn TEXT, $emailColumn TEXT, $phoneColumn TEXT, $imgColumn TEXT);");
    });
  }

  // Gravar Contato
  Future<Contact> saveContact(Contact contact) async {
    // Conexao com o BD
    Database dbContact = await db;
    contact.id = await dbContact.insert(contactTable, contact.toMap());
    return contact;
  }

  // Buscar Contato
  Future<Contact> getContact(int id) async {
    // Conexao com o BD
    Database dbContact = await db;
    List<Map> maps = await dbContact.query(contactTable,
        columns: [idColumn, nameColumn, emailColumn, phoneColumn, imgColumn],
        where: "$idColumn = ?",
        whereArgs: [id]);
    if (maps.length > 0) {
      return Contact.fromMap(maps.first);
    } else {
      return null;
    }
  }

  // Deletar Contato
  Future<int> deleteContact(int id) async {
    // Conexao com o BD
    Database dbContact = await db;
    return await dbContact
        .delete(contactTable, where: "$idColumn = ?", whereArgs: [id]);
  }

  // Editar Contato
  Future<int> updateContact(Contact contact) async {
    // Conexao com o BD
    Database dbContact = await db;
    return await dbContact.update(contactTable, contact.toMap(),
        where: "$idColumn = ?", whereArgs: [contact.id]);
  }

  // Listar Todos Contatos
  Future<List> getAllContact() async {
    // Conexao com o BD
    Database dbContact = await db;
    List listMap = await dbContact.rawQuery("SELECT * FROM $contactTable");
    List<Contact> listContact = List();
    for (Map item in listMap) {
      listContact.add(Contact.fromMap(item));
    }
    return listContact;
  }

  // Quantidade de Contatos Cadastrados
  getNumber() async {
    // Conexao com o BD
    Database dbContact = await db;
    return Sqflite.firstIntValue(
        await dbContact.rawQuery("SELECT COUNT(*) FROM $contactTable"));
  }

  // Fechar conexao com o BD
  Future close() async {
    // Conexao com o BD
    Database dbContact = await db;
    dbContact.close();
  }
}

class Contact {
  int id;
  String name;
  String email;
  String phone;
  String img;

  Contact() {}

  Contact.fromMap(Map map) {
    id = map[idColumn];
    name = map[nameColumn];
    email = map[emailColumn];
    phone = map[phoneColumn];
    img = map[imgColumn];
  }

  Map toMap() {
    Map<String, dynamic> map = {
      nameColumn: name,
      emailColumn: email,
      phoneColumn: phone,
      imgColumn: img
    };
    if (id != null) {
      map[idColumn] = id;
    }
    return map;
  }

  @override
  String toString() {
    return "Contact(id: $id, Name: $name, Email: $email, Phone: $phone, Img: $img)";
  }
}
