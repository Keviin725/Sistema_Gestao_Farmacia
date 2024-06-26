import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:sistema_gestao_farmacia/models/produto.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'adicionar_produto.dart';
import 'atualizar_produtos.dart';

class ListaProdutosScreen extends StatefulWidget {
  @override
  _ListaProdutosScreenState createState() => _ListaProdutosScreenState();
}

class _ListaProdutosScreenState extends State<ListaProdutosScreen> {
  List<Produto> produtos = [];

  @override
  void initState() {
    super.initState();
    carregarProdutos();
  }

  void carregarProdutos() async {
    final prefs = await SharedPreferences.getInstance();
    List<String>? produtosJson = prefs.getStringList('produtos');

    if (produtosJson != null) {
      produtos = produtosJson.map((produtoJson) => Produto.fromMap(jsonDecode(produtoJson))).toList();
    }

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Lista de Produtos'),
      ),
      body: ListView.builder(
        itemCount: produtos.length,
        itemBuilder: (context, index) {
          return Card(
            child: ListTile(
              leading: CircleAvatar(
                child: Text(produtos[index].nome[0]),
              ),
              title: Text(produtos[index].nome),
              subtitle: Text('${produtos[index].descricao} - MZN${produtos[index].preco} - Quantidade: ${produtos[index].estoque}'),
              trailing: IconButton(
                icon: Icon(Icons.edit),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => EditarProdutoScreen(produto: produtos[index])),
                  ).then((value) {
                    if (value == true) {
                      carregarProdutos();
                    }
                  });
                },
              ),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => AdicionarProdutoScreen()),
          ).then((value) {
            if (value == true) {
              carregarProdutos();
            }
          });
        },
        child: Icon(Icons.add),
      ),
    );
  }
}