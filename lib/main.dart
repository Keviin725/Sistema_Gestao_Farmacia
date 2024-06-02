import 'package:flutter/material.dart';
import 'screens/home_screen.dart';
import 'screens/clientes/lista_clientes.dart';
import 'screens/clientes/adicionar_cliente.dart';
import 'screens/clientes/submenu_clientes.dart';
import 'screens/clientes/atualizar_cliente.dart';
import 'screens/clientes/remover_cliente.dart';
import 'screens/produtos/lista_produtos.dart';
import 'screens/produtos/adicionar_produto.dart';
import 'screens/stock/lista_stock.dart';
import 'screens/stock/atualizar_stock.dart';
import 'screens/vendas/lista_vendas.dart';
import 'screens/vendas/nova_venda.dart';
import 'screens/relatorios/lista_relatorios.dart';

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
        '/clientes': (context) => SubmenuClientesScreen(),
        '/clientes/lista': (context) => ListaClientesScreen(),
        '/clientes/adicionar': (context) => AdicionarClienteScreen(),
        '/clientes/atualizar': (context) => AtualizarClienteScreen(),
        '/clientes/remover': (context) => RemoverClienteScreen(),
        '/produtos': (context) => ListaProdutosScreen(),
        '/produtos/adicionar': (context) => AdicionarProdutoScreen(),
        '/inventarios': (context) => ListaInventariosScreen(),
        '/inventarios/atualizar': (context) => AtualizarInventarioScreen(),
        '/vendas': (context) => ListaVendasScreen(),
        '/vendas/nova': (context) => NovaVendaScreen(),
        '/relatorios': (context) => ListaRelatoriosScreen(),
      },
    );
  }
}
