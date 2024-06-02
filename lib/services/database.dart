import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper {
  static final DatabaseHelper instance = DatabaseHelper._privateConstructor();
  static Database? _database;

  DatabaseHelper._privateConstructor();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    String path = join(await getDatabasesPath(), 'farmacia.db');
    return await openDatabase(path, version: 1, onCreate: _createDatabase);
  }

  Future<void> _createDatabase(Database db, int version) async {
    await db.execute('''
      CREATE TABLE clientes(
        id TEXT PRIMARY KEY,
        nome TEXT,
        endereco TEXT,
        telefone TEXT,
        email TEXT
      )
      ''');

    await db.execute('''
      CREATE TABLE transacoes(
        id TEXT PRIMARY KEY,
        cliente_id TEXT,
        descricao TEXT,
        valor REAL,
        data TEXT,
        FOREIGN KEY (cliente_id) REFERENCES clientes (id) ON DELETE CASCADE
      )
      ''');
  }
}
