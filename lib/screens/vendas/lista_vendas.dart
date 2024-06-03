import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sistema_gestao_farmacia/models/venda.dart';
import 'dart:convert';

class ListaVendasScreen extends StatefulWidget {
  @override
  _ListaVendasScreenState createState() => _ListaVendasScreenState();
}

class _ListaVendasScreenState extends State<ListaVendasScreen> {
  List<Venda> vendas = [];
  String clienteSelecionado = 'Todos';

  @override
  void initState() {
    super.initState();
    _getVendas();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Relatorio de Vendas'),
      ),
      body: vendas.isEmpty
          ? Center(child: Text('Nenhuma venda encontrada'))
          : ListView.builder(
              itemCount: vendas.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text('Produto: ${vendas[index].produtoId}'),
                  subtitle: Text('Cliente: ${vendas[index].clienteId}'),
                );
              },
            ),
    );
  }

  Future<void> _getVendas() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? vendasJson = prefs.getString('vendas');
    if (vendasJson != null) {
      List<dynamic> vendasList = jsonDecode(vendasJson);
      vendas = vendasList.map((venda) => Venda.fromJson(venda)).toList();
      setState(() {});
    }
  }
}