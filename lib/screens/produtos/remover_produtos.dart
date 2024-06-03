import 'package:flutter/material.dart';
import 'package:sistema_gestao_farmacia/models/produto.dart';
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class RemoverProdutoScreen extends StatefulWidget {
  @override
  _RemoverProdutoScreenState createState() => _RemoverProdutoScreenState();
}

class _RemoverProdutoScreenState extends State<RemoverProdutoScreen> {
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

  void _removeProduto(Produto produto) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String>? produtosJson = prefs.getStringList('produtos');
    if (produtosJson != null) {
      List<Produto> produtos = produtosJson.map((produtoJson) => Produto.fromMap(jsonDecode(produtoJson))).toList();
      produtos.removeWhere((item) => item.id == produto.id);
      await prefs.setStringList('produtos', produtos.map((produto) => jsonEncode(produto.toMap())).toList());
      setState(() {
        _produtos = produtos;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Produto removido com sucesso')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Remover Produto'),
      ),
      body: _produtos.isEmpty
          ? Center(child: Text('Nenhum produto encontrado'))
          : ListView.builder(
              itemCount: _produtos.length,
              itemBuilder: (context, index) {
                final produto = _produtos[index];
                return ListTile(
                  title: Text(produto.nome),
                  subtitle: Text('Preço: MZN ${produto.preco} - Estoque: ${produto.estoque}'),
                  trailing: IconButton(
                    icon: Icon(Icons.delete),
                    onPressed: () => _confirmRemoveProduto(produto),
                  ),
                );
              },
            ),
    );
  }

  void _confirmRemoveProduto(Produto produto) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Confirmar Remoção'),
        content: Text('Você tem certeza que deseja remover o produto ${produto.nome}?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: Text('Cancelar'),
          ),
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
              _removeProduto(produto);
            },
            child: Text('Remover'),
          ),
        ],
      ),
    );
  }
}
