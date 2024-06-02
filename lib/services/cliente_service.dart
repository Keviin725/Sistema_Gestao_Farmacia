import 'package:sqflite/sqflite.dart';

import 'database.dart';
import 'package:sistema_gestao_farmacia/models/cliente.dart';

class ClienteService {
  final DatabaseHelper _databaseService = DatabaseHelper.instance;

  Future<void> inserirCliente(Cliente cliente) async {
    final db = await _databaseService.database;
    await db.insert(
      'clientes',
      cliente.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<void> atualizarCliente(Cliente cliente) async {
    final db = await _databaseService.database;
    await db.update(
      'clientes',
      cliente.toMap(),
      where: 'id = ?',
      whereArgs: [cliente.id],
    );
  }

  Future<void> removerCliente(String id) async {
    final db = await _databaseService.database;
    await db.delete(
      'clientes',
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  Future<List<Cliente>> getClientes() async {
    final db = await _databaseService.database;
    final List<Map<String, dynamic>> maps = await db.query('clientes');
    return List.generate(maps.length, (i) {
      return Cliente.fromMap(maps[i]);
    });
  }
}
