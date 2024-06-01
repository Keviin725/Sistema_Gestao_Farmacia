import 'package:flutter/material.dart';
import 'screens/home_screen.dart';

void main() {
  runApp(FarmaciaGestaoApp());
}

class FarmaciaGestaoApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Sistema de Gestão de Farmácia',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: HomeScreen(),
      routes: {
        '/clientes': (context) => ListaClientesScreen(),
        '/produtos': (context) => ListaProdutosScreen(),
        '/inventarios': (context) => ListaInventariosScreen(),
        '/vendas': (context) => ListaVendasScreen(),
        '/relatorios': (context) => ListaRelatoriosScreen(),
      },
    );
  }
}
