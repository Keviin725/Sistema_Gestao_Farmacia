import 'package:sqflite/sqflite.dart';
import 'package:sistema_gestao_farmacia/models/cliente.dart';
import 'package:sistema_gestao_farmacia/models/transacao.dart';
import 'package:sistema_gestao_farmacia/services/cliente_service.dart';
import 'package:sistema_gestao_farmacia/services/database.dart';

class TransacaoService {
  final ClienteService clienteService = ClienteService();

  Future<List<Transacao>> getTransacoesDoCliente(Cliente cliente) async {
    final Database db = await DatabaseHelper.instance.database;
    final List<Map<String, dynamic>> maps = await db.query(
      'transacoes',
      where: 'cliente_id = ?',
      whereArgs: [cliente.id],
    );

    return List.generate(maps.length, (i) {
      return Transacao(
        id: maps[i]['id'],
        clienteId: maps[i]['cliente_id'],
        descricao: maps[i]['descricao'],
        valor: maps[i]['valor'],
        data: DateTime.parse(maps[i]['data']),
      );
    });
  }

  Future<void> adicionarTransacao(Transacao transacao) async {
    final Database db = await DatabaseHelper.instance.database;
    await db.insert(
      'transacoes',
      transacao.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }
}
