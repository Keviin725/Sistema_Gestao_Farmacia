import 'package:flutter/material.dart';

class SubmenuStockScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Gestão de Stock'),
      ),
      body: ListView(
        children: [
          Card(
            child: ListTile(
              leading: Icon(Icons.update),
              title: Text('1.1 Atualizar Stock'),
              onTap: () {
                Navigator.pushNamed(context, '/inventarios/atualizar');
              },
            ),
          ),
          // Adicione mais opções conforme necessário
          // Exemplo:
          
          Card(
            child: ListTile(
              leading: Icon(Icons.add),
              title: Text('1.2 Adicionar Stock'),
              onTap: () {
                Navigator.pushNamed(context, '/inventarios/adicionar');
              },
            ),
          ),
          Card(
            child: ListTile(
              leading: Icon(Icons.delete),
              title: Text('1.3 Remover Stock'),
              onTap: () {
                Navigator.pushNamed(context, '/inventarios/remover');
              },
            ),
          ),
          
        ],
      ),
    );
  }
}