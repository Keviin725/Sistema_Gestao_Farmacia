import 'package:flutter/material.dart';
import 'package:sistema_gestao_farmacia/models/cliente.dart';
import 'atualizar_cliente.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import 'adicionar_cliente.dart';

class ListaClientesScreen extends StatefulWidget {
  @override
  _ListaClientesScreenState createState() => _ListaClientesScreenState();
}

class _ListaClientesScreenState extends State<ListaClientesScreen> {
  List<Cliente> clientes = [];

  @override
  void initState() {
    super.initState();
    loadClientes();
  }

  void loadClientes() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String>? clientesJson = prefs.getStringList('clientes');
    if (clientesJson != null) {
      setState(() {
        clientes = clientesJson.map((clienteJson) => Cliente.fromMap(jsonDecode(clienteJson))).toList();
      });
    }
  }

  void _updateCliente(Cliente clienteAtualizado) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String>? clientesJson = prefs.getStringList('clientes');
    if (clientesJson != null) {
      List<Cliente> clientes = clientesJson.map((clienteJson) => Cliente.fromMap(jsonDecode(clienteJson))).toList();
      int index = clientes.indexWhere((cliente) => cliente.id == clienteAtualizado.id);
      if (index != -1) {
        clientes[index] = clienteAtualizado;
        await prefs.setStringList('clientes', clientes.map((cliente) => jsonEncode(cliente.toMap())).toList());
        setState(() {
          this.clientes = clientes;
        });
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Cliente atualizado com sucesso')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Lista de Clientes'),
      ),
      body: ListView.builder(
        itemCount: clientes.length,
        itemBuilder: (context, index) {
          Cliente cliente = clientes[index];
          return Card(
            child: ListTile(
              leading: Icon(Icons.person),
              title: Text(cliente.nome),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Endereço: ${cliente.endereco}'),
                  Text('Telefone: ${cliente.telefone}'),
                  Text('E-mail: ${cliente.email}'),
                ],
              ),
              trailing: IconButton(
                icon: Icon(Icons.edit),
                onPressed: () async {
                  final atualizado = await Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => AtualizarClienteScreen(cliente: cliente),
                    ),
                  );
                  if (atualizado != null) {
                    _updateCliente(atualizado);
                  }
                },
              ),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => AdicionarClienteScreen()),
          ).then((value) {
            loadClientes();
          });
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
