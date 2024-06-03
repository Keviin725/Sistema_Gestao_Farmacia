import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';
import 'package:sqflite_common_ffi_web/sqflite_ffi_web.dart';
import 'package:sistema_gestao_farmacia/models/cliente.dart';
import 'screens/home_screen.dart';
import 'screens/clientes/lista_clientes.dart';
import 'screens/clientes/adicionar_cliente.dart';
import 'screens/clientes/submenu_clientes.dart';
import 'screens/clientes/atualizar_cliente.dart';
import 'screens/clientes/remover_cliente.dart';
import 'screens/clientes/conta_corrente.dart';
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
import 'services/database.dart';

void main() {
  if (kIsWeb) {
    // Use sqflite_common_ffi_web for web
    databaseFactory = databaseFactoryFfiWeb;
  } else {
    // Use sqflite_common_ffi for desktop and mobile
    sqfliteFfiInit();
    databaseFactory = databaseFactoryFfi;
  }

  WidgetsFlutterBinding.ensureInitialized(); // Garante que os serviços do Flutter estejam inicializados
    final dbHelper = DatabaseHelper.instance;
  dbHelper.database;


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
        '/produtos': (context) => SubmenuProdutosScreen(),
        '/produtos/adicionar': (context) => AdicionarProdutoScreen(),
        '/inventarios': (context) => SubmenuStockScreen(),
        '/inventarios/atualizar': (context) => AtualizarInventarioScreen(),
        '/vendas': (context) => SubmenuVendasScreen(),
        '/vendas/nova': (context) {
  final Cliente cliente = ModalRoute.of(context)!.settings.arguments as Cliente;
  return NovaVendaScreen(clienteId: cliente.id);
},
        '/relatorios': (context) => SubmenuRelatoriosScreen(),
        '/clientes/conta-corrente': (context) => VerContaCorrenteScreen()
          
      },
    );
  }
}
