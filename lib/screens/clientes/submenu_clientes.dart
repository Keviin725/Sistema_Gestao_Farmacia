import 'package:flutter/material.dart';

class SubmenuClientesScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Gestão de Clientes'),
      ),
      body: ListView(
        children: [
          Card(
            child: ListTile(
              leading: Icon(Icons.add),
              title: Text('Criar Cliente'),
              onTap: () {
                Navigator.pushNamed(context, '/clientes/adicionar');
              },
            ),
          ),
          Card(
            child: ListTile(
              leading: Icon(Icons.update),
              title: Text('Atualizar Cliente'),
              onTap: () {
                Navigator.pushNamed(context, '/clientes/atualizar');
              },
            ),
          ),
          Card(
            child: ListTile(
              leading: Icon(Icons.update),
              title: Text('Ver Conta Corrente do Cliente'),
              onTap: () {
                //Navigator.pushNamed(context, '/clientes/atualizar');
              },
            ),
          ),
          Card(
            child: ListTile(
              leading: Icon(Icons.delete),
              title: Text('Remover Cliente'),
              onTap: () {
                Navigator.pushNamed(context, '/clientes/remover');
              },
            ),
          ),
        ],
      ),
    );
  }
}