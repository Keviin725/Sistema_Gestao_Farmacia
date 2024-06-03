import 'package:sqflite/sqflite.dart';
import 'package:sistema_gestao_farmacia/models/cliente.dart';
import 'package:sistema_gestao_farmacia/services/database.dart';

class ClienteService {
  final dbHelper = DatabaseHelper.instance;
Future<void> insertCliente(Cliente cliente) async {
  try {
    final db = await dbHelper.database;
    print('Tentando inserir cliente: $cliente');
    try {
      var result = await db.insert(
        'clientes',
        cliente.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
      print('Resultado da inserção: $result');
      print('Cliente inserido com sucesso');
    } catch (e) {
      print('Ocorreu um erro ao inserir o cliente no banco de dados: $e');
    }
  } catch (e) {
    print('Ocorreu um erro ao inserir o cliente: $e');
    throw e;  // Re-lança a exceção para que ela possa ser tratada em outro lugar
  }
}

  Future<List<Cliente>> getClientes() async {
    final db = await dbHelper.database;
    final List<Map<String, dynamic>> maps = await db.query('clientes');
    return List.generate(maps.length, (i) {
      return Cliente(
        id: maps[i]['id'],
        nome: maps[i]['nome'],
        endereco: maps[i]['endereco'],
        telefone: maps[i]['telefone'],
        email: maps[i]['email'],
      );
    });
  }

  Future<void> updateCliente(Cliente cliente) async {
    final db = await dbHelper.database;
    await db.update(
      'clientes',
      cliente.toMap(),
      where: 'id = ?',
      whereArgs: [cliente.id],
    );
  }

  Future<void> deleteCliente(String id) async {
    final db = await dbHelper.database;
    await db.delete(
      'clientes',
      where: 'id = ?',
      whereArgs: [id],
    );
  }
}
