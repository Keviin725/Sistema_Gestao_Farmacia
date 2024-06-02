import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:sistema_gestao_farmacia/models/cliente.dart';

class ClienteService {
  static final ClienteService _instance = ClienteService._internal();
  Database? _database;

  factory ClienteService() {
    return _instance;
  }

  ClienteService._internal();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    return openDatabase(
      join(await getDatabasesPath(), 'farmacia.db'),
      onCreate: (db, version) {
        return db.execute(
          "CREATE TABLE clientes(id TEXT PRIMARY KEY, nome TEXT, endereco TEXT, telefone TEXT, email TEXT)",
        );
      },
      version: 1,
    );
  }

  Future<void> inserirCliente(Cliente cliente) async {
    final db = await database;
    await db.insert(
      'clientes',
      cliente.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<List<Cliente>> getClientes() async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query('clientes');
    return List.generate(maps.length, (i) {
      return Cliente(
        id: maps[i]['id'],
        nome: maps[i]['nome'],
        endereco: maps[i]['endereco'],
        telefone: maps[i]['telefone'],
        email: maps[i]['email'],
      );
    });
  }
  Future<void> atualizarCliente(Cliente clienteAtualizado) async {
  final db = await database;
  await db.update(
    'clientes',
    clienteAtualizado.toMap(),
    where: 'id = ?',
    whereArgs: [clienteAtualizado.id],
  );
}



  // Implementar outras operações (atualizar, deletar, etc)
}
