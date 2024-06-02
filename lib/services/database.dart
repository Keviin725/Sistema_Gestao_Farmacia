import 'package:sqflite/sqflite.dart';
import 'package:sqflite_web/sqflite_web.dart';

class DatabaseHelper {
  static final _databaseName = 'farmacia.db';
  static final _databaseVersion = 1;

  DatabaseHelper._privateConstructor();
  static final DatabaseHelper instance = DatabaseHelper._privateConstructor();

  static Database? _database;
  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  _initDatabase() async {
    // Use sqflite_web para inicializar o banco de dados
    await SqflitePluginWeb.registerWebDatabaseFactory();
    return await openDatabase(
      _databaseName,
      version: _databaseVersion,
      onCreate: _onCreate,
    );
  }

  // Código SQL para criar o banco de dados e as tabelas
  Future _onCreate(Database db, int version) async {
    await db.execute('''
          CREATE TABLE clientes (
            id TEXT PRIMARY KEY,
            nome TEXT,
            endereco TEXT,
            telefone TEXT,
            email TEXT
          )
          ''');

    await db.execute('''
          CREATE TABLE produtos (
            id TEXT PRIMARY KEY,
            nome TEXT,
            descricao TEXT,
            preco REAL,
            estoque INTEGER
          )
          ''');

    await db.execute('''
          CREATE TABLE vendas (
            id TEXT PRIMARY KEY,
            clienteId TEXT,
            produtoId TEXT,
            quantidade INTEGER,
            data TEXT,
            valorComIVA REAL,
            valorIVA REAL
          )
          ''');

    await db.execute('''
          CREATE TABLE transacoes (
            id TEXT PRIMARY KEY,
            clienteId TEXT,
            descricao TEXT,
            data TEXT,
            valor REAL
          )
          ''');
  }
}
