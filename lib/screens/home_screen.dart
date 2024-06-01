import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Sistema de Gestão de Farmácia'),
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              child: Text(
                'Menu',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                ),
              ),
              decoration: BoxDecoration(
                color: Colors.blue,
              ),
            ),
            ListTile(
              leading: Icon(Icons.people),
              title: Text('Clientes'),
              onTap: () {
                Navigator.pushNamed(context, '/clientes');
              },
            ),
            ListTile(
              leading: Icon(Icons.medical_services),
              title: Text('Produtos'),
              onTap: () {
                Navigator.pushNamed(context, '/produtos');
              },
            ),
            ListTile(
              leading: Icon(Icons.inventory),
              title: Text('Inventarios'),
              onTap: () {
                Navigator.pushNamed(context, '/inventarios');
              },
            ),
            ListTile(
              leading: Icon(Icons.sell),
              title: Text('Vendas'),
              onTap: () {
                Navigator.pushNamed(context, '/vendas');
              },
            ),
            ListTile(
              leading: Icon(Icons.bar_chart),
              title: Text('Relatórios'),
              onTap: () {
                Navigator.pushNamed(context, '/relatorios');
              },
            ),
          ],
        ),
      ),
      body: Center(
        child: Text('Bem-vindo ao Sistema de Gestão de Farmácia'),
      ),
    );
  }
}
