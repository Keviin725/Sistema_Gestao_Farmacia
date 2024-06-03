import 'package:flutter/material.dart';

class SubmenuProdutosScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Gestão de Produtos'),
      ),
      body: ListView(
        children: [
          Card(
            child: ListTile(
              leading: Icon(Icons.list),
              title: Text('Lista de Produtos'),
              onTap: () {
                Navigator.pushNamed(context, '/produtos/list');
              },
            ),
          ),
          Card(
            child: ListTile(
              leading: Icon(Icons.add),
              title: Text('Adicionar Produto'),
              onTap: () {
                Navigator.pushNamed(context, '/produtos/adicionar');
              },
            ),
          ),
          // Adicione mais opções conforme necessário
          // Exemplo:
          
          Card(
            child: ListTile(
              leading: Icon(Icons.update),
              title: Text('Atualizar Produto'),
              onTap: () {
                Navigator.pushNamed(context, '/produtos/atualizar');
              },
            ),
          ),
          Card(
            child: ListTile(
              leading: Icon(Icons.delete),
              title: Text('1.3 Remover Produto'),
              onTap: () {
                Navigator.pushNamed(context, '/produtos/remover');
              },
            ),
          ),
          
        ],
      ),
    );
  }
}