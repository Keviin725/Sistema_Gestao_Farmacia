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
              leading: Icon(Icons.list),
              title: Text('Lista de Stock'),
              onTap: () {
                Navigator.pushNamed(context, '/inventario/list');
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
                Navigator.pushNamed(context, '/produtos/adicionar');
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