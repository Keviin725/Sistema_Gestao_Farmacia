import 'package:flutter/material.dart';

class SubmenuRelatoriosScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Gestão de Relatórios'),
      ),
      body: ListView(
        children: [
          // Adicione opções de relatórios conforme necessário
          // Exemplo:
          
          Card(
            child: ListTile(
              leading: Icon(Icons.insert_chart),
              title: Text('Relatório de Vendas'),
              onTap: () {
                Navigator.pushNamed(context, '/vendas/list');
              },
            ),
          ),
          Card(
            child: ListTile(
              leading: Icon(Icons.bar_chart),
              title: Text('Relatório de Stock'),
              onTap: () {
                Navigator.pushNamed(context, '/relatorios/stock');
              },
            ),
          ),
          Card(
            child: ListTile(
              leading: Icon(Icons.bar_chart),
              title: Text('Relatório de Produtos mais vendidos'),
              onTap: () {
                //Navigator.pushNamed(context, '/relatorios/stock');
              },
            ),
          ),
          
        ],
      ),
    );
  }
}