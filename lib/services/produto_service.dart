import 'package:sqflite/sqflite.dart';
import 'database.dart';
import 'package:sistema_gestao_farmacia/models/produto.dart';

class ProdutoService {
  final DatabaseHelper _databaseService = DatabaseHelper.instance;

  Future<void> inserirProduto(Produto produto) async {
    final db = await _databaseService.database;
    await db.insert(
      'produtos',
      produto.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<void> atualizarProduto(Produto produto) async {
    final db = await _databaseService.database;
    await db.update(
      'produtos',
      produto.toMap(),
      where: 'id = ?',
      whereArgs: [produto.id],
    );
  }

  Future<void> removerProduto(String id) async {
    final db = await _databaseService.database;
    await db.delete(
      'produtos',
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  Future<List<Produto>> getProdutos() async {
    final db = await _databaseService.database;
    final List<Map<String, dynamic>> maps = await db.query('produtos');
    return List.generate(maps.length, (i) {
      return Produto.fromMap(maps[i]);
    });
  }
}
