import 'package:flutter/material.dart';
import 'package:sistema_gestao_farmacia/models/cliente.dart';
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class RemoverClienteScreen extends StatefulWidget {
  @override
  _RemoverClienteScreenState createState() => _RemoverClienteScreenState();
}

class _RemoverClienteScreenState extends State<RemoverClienteScreen> {
  List<Cliente> _clientes = [];

  @override
  void initState() {
    super.initState();
    _loadClientes();
  }

  void _loadClientes() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String>? clientesJson = prefs.getStringList('clientes');
    if (clientesJson != null) {
      setState(() {
        _clientes = clientesJson.map((clienteJson) => Cliente.fromMap(jsonDecode(clienteJson))).toList();
      });
    }
  }

  void _removeCliente(Cliente cliente) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String>? clientesJson = prefs.getStringList('clientes');
    if (clientesJson != null) {
      List<Cliente> clientes = clientesJson.map((clienteJson) => Cliente.fromMap(jsonDecode(clienteJson))).toList();
      clientes.removeWhere((item) => item.id == cliente.id);
      await prefs.setStringList('clientes', clientes.map((cliente) => jsonEncode(cliente.toMap())).toList());
      setState(() {
        _clientes = clientes;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Cliente removido com sucesso')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Remover Cliente'),
      ),
      body: _clientes.isEmpty
          ? Center(child: Text('Nenhum cliente encontrado'))
          : ListView.builder(
              itemCount: _clientes.length,
              itemBuilder: (context, index) {
                final cliente = _clientes[index];
                return ListTile(
                  title: Text(cliente.nome),
                  subtitle: Text(cliente.email),
                  trailing: IconButton(
                    icon: Icon(Icons.delete),
                    onPressed: () => _confirmRemoveCliente(cliente),
                  ),
                );
              },
            ),
    );
  }

  void _confirmRemoveCliente(Cliente cliente) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Confirmar Remoção'),
        content: Text('Você tem certeza que deseja remover o cliente ${cliente.nome}?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: Text('Cancelar'),
          ),
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
              _removeCliente(cliente);
            },
            child: Text('Remover'),
          ),
        ],
      ),
    );
  }
}
