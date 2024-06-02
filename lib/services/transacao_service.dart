import 'package:sqflite/sqflite.dart';
import 'package:sistema_gestao_farmacia/models/venda.dart';
import 'package:sistema_gestao_farmacia/models/transacao.dart';
import 'database.dart';

class TransacaoService {
  final DatabaseHelper _databaseService = DatabaseHelper.instance;

  Future<void> inserirVenda(Venda venda) async {
    final db = await _databaseService.database;
    await db.insert(
      'vendas',
      venda.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<List<Venda>> getVendas() async {
    final db = await _databaseService.database;
    final List<Map<String, dynamic>> maps = await db.query('vendas');
    return List.generate(maps.length, (i) {
      return Venda.fromMap(maps[i]);
    });
  }

  Future<List<Venda>> getVendasPorCliente(String clienteId) async {
    final db = await _databaseService.database;
    final List<Map<String, dynamic>> maps = await db.query(
      'vendas',
      where: 'clienteId = ?',
      whereArgs: [clienteId],
    );
    return List.generate(maps.length, (i) {
      return Venda.fromMap(maps[i]);
    });
  }
  Future<List<Transacao>> getTransacoesPorCliente(String clienteId) async {
  final db = await _databaseService.database;
  final List<Map<String, dynamic>> maps = await db.query(
    'transacoes',
    where: 'clienteId = ?',
    whereArgs: [clienteId],
  );
  return List.generate(maps.length, (i) {
    return Transacao.fromMap(maps[i]);
  });
}


  Future<List<Map<String, dynamic>>> getArtigosMaisVendidos(int limite) async {
    final db = await _databaseService.database;
    final List<Map<String, dynamic>> maps = await db.rawQuery(
      'SELECT produtoId, SUM(quantidade) as totalQuantidade FROM vendas GROUP BY produtoId ORDER BY totalQuantidade DESC LIMIT ?',
      [limite],
    );
    return maps;
  }

  Future<List<Map<String, dynamic>>> getProdutosAbaixoDoPontoDeEncomenda() async {
    final db = await _databaseService.database;
    final List<Map<String, dynamic>> maps = await db.rawQuery(
      'SELECT * FROM produtos WHERE estoque <= 5',
    );
    return maps;
  }
}
