import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:sistema_gestao_farmacia/models/produto.dart';

class ProdutoService {
  static final ProdutoService _instance = ProdutoService._internal();
  Database? _database;

  factory ProdutoService() {
    return _instance;
  }

  ProdutoService._internal();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    return openDatabase(
      join(await getDatabasesPath(), 'farmacia.db'),
      onCreate: (db, version) {
        db.execute(
          "CREATE TABLE produtos(id TEXT PRIMARY KEY, nome TEXT, descricao TEXT, preco REAL, estoque INTEGER)",
        );
        // Adicionar a criação da tabela clientes se necessário
      },
      version: 1,
    );
  }

  Future<void> inserirProduto(Produto produto) async {
    final db = await database;
    await db.insert(
      'produtos',
      produto.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<List<Produto>> getProdutos() async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query('produtos');
    return List.generate(maps.length, (i) {
      return Produto(
        id: maps[i]['id'],
        nome: maps[i]['nome'],
        descricao: maps[i]['descricao'],
        preco: maps[i]['preco'],
        estoque: maps[i]['estoque'],
      );
    });
  }

  // Implementar outras operações (atualizar, deletar, etc)
}
