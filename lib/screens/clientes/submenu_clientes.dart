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
          ListTile(
            title: Text('1.1 Criar Cliente'),
            onTap: () {
              Navigator.pushNamed(context, '/clientes/adicionar');
            },
          ),
          ListTile(
            title: Text('1.2 Atualizar Cliente'),
            onTap: () {
              // Navegar para a tela de atualização de clientes (a ser criada)
              Navigator.pushNamed(context, '/clientes/atualizar');
            },
          ),
          ListTile(
            title: Text('1.3 Remover Cliente'),
            onTap: () {
              // Navegar para a tela de remoção de clientes (a ser criada)
              Navigator.pushNamed(context, '/clientes/remover');
            },
          ),
        ],
      ),
    );
  }
}
