import 'package:flutter/material.dart';
import 'package:sistema_gestao_farmacia/models/produto.dart';
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class ListaStockScreen extends StatefulWidget {
  @override
  _ListaStockScreenState createState() => _ListaStockScreenState();
}

class _ListaStockScreenState extends State<ListaStockScreen> {
  List<Produto> _produtos = [];

  @override
  void initState() {
    super.initState();
    _loadProdutos();
  }

  void _loadProdutos() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String>? produtosJson = prefs.getStringList('produtos');
    if (produtosJson != null) {
      setState(() {
        _produtos = produtosJson.map((produtoJson) => Produto.fromMap(jsonDecode(produtoJson))).toList();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Lista de Stock'),
      ),
      body: _produtos.isEmpty
          ? Center(child: Text('Nenhum produto encontrado'))
          : ListView.builder(
              itemCount: _produtos.length,
              itemBuilder: (context, index) {
                final produto = _produtos[index];
                return Card(
                  elevation: 3,
                  margin: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                  child: ListTile(
                    title: Text(produto.nome),
                    subtitle: Text('Quantidade em estoque: ${produto.estoque}'),
                    onTap: () {
                      // Implemente a ação de clique se desejar
                    },
                  ),
                );
              },
            ),
    );
  }
}
