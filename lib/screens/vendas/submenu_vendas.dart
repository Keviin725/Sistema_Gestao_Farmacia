import 'package:flutter/material.dart';

class SubmenuVendasScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Gestão de Vendas'),
      ),
      body: ListView(
        children: [
          
          Card(
            child: ListTile(
              leading: Icon(Icons.add_shopping_cart),
              title: Text('Nova Venda'),
              onTap: () {
                Navigator.pushNamed(context, '/vendas/nova');
              },
            ),
          ),
          // Adicione mais opções conforme necessário
          
          Card(
            child: ListTile(
              leading: Icon(Icons.update),
              title: Text('Atualizar Venda'),
              onTap: () {
                Navigator.pushNamed(context, '/vendas/atualizar');
              },
            ),
          ),
          Card(
            child: ListTile(
              leading: Icon(Icons.delete),
              title: Text('Cancelar Venda'),
              onTap: () {
                Navigator.pushNamed(context, '/vendas/cancelar');
              },
            ),
          ),
          
        ],
      ),
    );
  }
}