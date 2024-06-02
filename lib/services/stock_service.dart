import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:sistema_gestao_farmacia/models/produto.dart';

class EstoqueService {
  static final EstoqueService _instance = EstoqueService._internal();
  Database? _database;

  factory EstoqueService() {
    return _instance;
  }

  EstoqueService._internal();

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
          "CREATE TABLE produtos(id TEXT PRIMARY KEY, nome TEXT, descricao TEXT, preco REAL, estoque INTEGER)",
        );
      },
      version: 1,
    );
  }

  Future<List<Produto>> getEstoqueAtual() async {
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

  Future<List<Produto>> getProdutosParaEncomenda() async {
  final db = await database;
  final List<Map<String, dynamic>> maps = await db.query(
    'produtos',
    where: 'estoque < ?',
    whereArgs: [5],
  );
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

}
