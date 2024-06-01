import 'package:flutter/material.dart';
import 'package:sistema_gestao_farmacia/models/cliente.dart';
import 'package:sistema_gestao_farmacia/services/cliente_service.dart';
import 'adicionar_cliente.dart';

class ListaClientesScreen extends StatefulWidget {
  @override
  _ListaClientesScreenState createState() => _ListaClientesScreenState();
}

class _ListaClientesScreenState extends State<ListaClientesScreen> {
  final ClienteService clienteService = ClienteService();
  List<Cliente> clientes = [];

  @override
  void initState() {
    super.initState();
    carregarClientes();
  }

  void carregarClientes() async {
    clientes = await clienteService.getClientes();
    setState(() {});
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
          return ListTile(
            title: Text(clientes[index].nome),
            subtitle: Text(clientes[index].email),
            onTap: () {
              // Implementar navegação para detalhes do cliente
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => AdicionarClienteScreen()),
          ).then((value) {
            if (value == true) {
              carregarClientes();
            }
          });
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
