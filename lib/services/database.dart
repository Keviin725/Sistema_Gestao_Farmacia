import 'package:sqflite/sqflite.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';
import 'package:sqflite_common_ffi_web/sqflite_ffi_web.dart';
import 'package:path/path.dart';
//import 'package:path_provider/path_provider.dart';

class DatabaseHelper {
  static final _databaseName = 'farmacia.db';
  static final _databaseVersion = 1;

  DatabaseHelper._privateConstructor();
  static final DatabaseHelper instance = DatabaseHelper._privateConstructor();

  static Database? _database;
  Future<Database> get database async {
    if (_database != null) {
      print('Banco de dados já inicializado');
      return _database!;
    }
    print('Inicializando o banco de dados...');
    _database = await _initDatabase();
    print('Banco de dados inicializado com sucesso');
    return _database!;
  }
  Future<Database> _initDatabase() async {
    try {
      String path = join(await getDatabasesPath(), _databaseName);
      print('Caminho do banco de dados: $path');
      var db = await openDatabase(path, version: _databaseVersion, onCreate: _onCreate);
      print('Banco de dados aberto com sucesso');
      return db;
    } catch (e) {
      print("Erro ao inicializar o banco de dados: $e");
      throw e;
    }
  }

  Future _onCreate(Database db, int version) async {
    print('Criando tabelas...');
    await db.execute('''
      CREATE TABLE clientes (
        id TEXT PRIMARY KEY,
        nome TEXT,
        endereco TEXT,
        telefone TEXT,
        email TEXT
      )
    ''');
    print('Tabela clientes criada');

    await db.execute('''
          CREATE TABLE produtos (
            id TEXT PRIMARY KEY,
            nome TEXT,
            descricao TEXT,
            preco REAL,
            estoque INTEGER
          )
          ''');
    print('Tabela produtos criada');

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
    print('Tabela vendas criada');

    await db.execute('''
          CREATE TABLE transacoes (
            id TEXT PRIMARY KEY,
            clienteId TEXT,
            descricao TEXT,
            data TEXT,
            valor REAL
          )
          ''');
    print('Tabela transacoes criada');
  }
}