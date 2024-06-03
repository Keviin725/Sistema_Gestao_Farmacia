import 'package:flutter/material.dart';
import 'package:sistema_gestao_farmacia/models/cliente.dart';
import 'package:sistema_gestao_farmacia/services/cliente_service.dart';
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