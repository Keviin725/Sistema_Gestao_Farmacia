import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseHelper {
  static final _databaseName = 'farmacia.db';
  static final _databaseVersion = 1;

  // Torna esta classe singleton
  DatabaseHelper._privateConstructor();
  static final DatabaseHelper instance = DatabaseHelper._privateConstructor();

  // Tem apenas uma referência ao banco de dados
  static Database? _database;
  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  // Abre o banco de dados e o cria se ele não existir
  _initDatabase() async {
    try {
      String path = join(await getDatabasesPath(), _databaseName);
      return await openDatabase(path,
          version: _databaseVersion,
          onCreate: _onCreate);
    } catch (e) {
      print("Erro ao inicializar o banco de dados: $e");
      throw e; // Re-throw a exceção para notificar o chamador
    }
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
