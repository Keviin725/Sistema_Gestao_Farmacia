import 'package:flutter/material.dart';
import 'package:sistema_gestao_farmacia/models/cliente.dart';
import 'screens/home_screen.dart';
import 'screens/clientes/lista_clientes.dart';
import 'screens/clientes/adicionar_cliente.dart';
import 'screens/clientes/submenu_clientes.dart';
import 'screens/clientes/atualizar_cliente.dart';
import 'screens/clientes/remover_cliente.dart';
import 'screens/produtos/lista_produtos.dart';
import 'screens/produtos/submenu_produtos.dart';
import 'screens/produtos/adicionar_produto.dart';
import 'screens/stock/lista_stock.dart';
import 'screens/stock/submenu_stock.dart';
import 'screens/stock/atualizar_stock.dart';
import 'screens/vendas/lista_vendas.dart';
import 'screens/vendas/submenu_vendas.dart';
import 'screens/vendas/nova_venda.dart';
import 'screens/relatorios/lista_relatorios.dart';
import 'screens/relatorios/submenu_relatorios.dart';

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
        '/clientes/atualizar': (context) {
  final Cliente cliente = ModalRoute.of(context)!.settings.arguments as Cliente;
  return AtualizarClienteScreen(cliente: cliente);
},

        '/clientes/remover': (context) => RemoverClienteScreen(),
        '/produtos': (context) => SubmenuProdutosScreen(),
        '/produtos/adicionar': (context) => AdicionarProdutoScreen(),
        '/inventarios': (context) => SubmenuStockScreen(),
        '/inventarios/atualizar': (context) => AtualizarInventarioScreen(),
        '/vendas': (context) => SubmenuVendasScreen(),
        '/vendas/nova': (context) => NovaVendaScreen(),
        '/relatorios': (context) => SubmenuRelatoriosScreen(),
      },
    );
  }
}
