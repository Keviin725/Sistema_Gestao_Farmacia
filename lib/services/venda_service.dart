import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:sistema_gestao_farmacia/models/venda.dart';

class VendaService {
  static final VendaService _instance = VendaService._internal();
  Database? _database;

  factory VendaService() {
    return _instance;
  }

  VendaService._internal();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    return openDatabase(
      join(await getDatabasesPath(), 'farmacia.db'),
      onCreate: (db, version) async {
        await db.execute(
          "CREATE TABLE vendas(id TEXT PRIMARY KEY, produtoId TEXT, quantidade INTEGER, data TEXT)",
        );
        await db.execute(
          "CREATE TABLE produtos(id TEXT PRIMARY KEY, nome TEXT, descricao TEXT, preco REAL, estoque INTEGER)",
        );
      },
      version: 1,
    );
  }

  Future<void> inserirVenda(Venda venda) async {
    final db = await database;
    await db.insert(
      'vendas',
      venda.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<List<Map<String, dynamic>>> getProdutosMaisVendidos() async {
    final db = await database;
    final result = await db.rawQuery(
      'SELECT produtoId, SUM(quantidade) as total_vendido FROM vendas GROUP BY produtoId ORDER BY total_vendido ASC LIMIT 5',
    );
    return result;
  }
}
