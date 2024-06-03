import 'package:flutter/material.dart';
import 'package:sistema_gestao_farmacia/models/produto.dart';
import 'package:sistema_gestao_farmacia/services/produto_service.dart';
import 'dart:convert';
import 'dart:io';
import 'package:shared_preferences/shared_preferences.dart';

class EditarProdutoScreen extends StatefulWidget {
  final Produto produto;

  const EditarProdutoScreen({required this.produto});

  @override
  _EditarProdutoScreenState createState() => _EditarProdutoScreenState();
}

class _EditarProdutoScreenState extends State<EditarProdutoScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nomeController = TextEditingController();
  final _descricaoController = TextEditingController();
  final _precoController = TextEditingController();
  final _estoqueController = TextEditingController();
  final ProdutoService produtoService = ProdutoService();

  @override
  void initState() {
    super.initState();
    _nomeController.text = widget.produto.nome;
    _descricaoController.text = widget.produto.descricao;
    _precoController.text = widget.produto.preco.toString();
    _estoqueController.text = widget.produto.estoque.toString();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Editar Produto'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              TextFormField(
                controller: _nomeController,
                decoration: InputDecoration(
                  labelText: 'Nome',
                  icon: Icon(Icons.shopping_cart),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor, insira o nome';
                  }
                  return null;
                },
              ),
              SizedBox(height: 20),
              TextFormField(
                controller: _descricaoController,
                decoration: InputDecoration(
                  labelText: 'Descrição',
                  icon: Icon(Icons.description),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor, insira a descrição';
                  }
                  return null;
                },
              ),
              SizedBox(height: 20),
              TextFormField(
                controller: _precoController,
                decoration: InputDecoration(
                  labelText: 'Preço',
                  icon: Icon(Icons.attach_money),
                ),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor, insira o preço';
                  }
                  return null;
                },
              ),
              SizedBox(height: 20),
              TextFormField(
                controller: _estoqueController,
                decoration: InputDecoration(
                  labelText: 'Quantidade',
                  icon: Icon(Icons.store),
                ),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor, insira a quantidade em estoque';
                  }
                  return null;
                },
              ),
              SizedBox(height: 40),
              ElevatedButton(
                onPressed: () async {
                  if (_formKey.currentState?.validate() == true) {
                    final novoProduto = Produto(
                      id: widget.produto.id,
                      nome: _nomeController.text,
                      descricao: _descricaoController.text,
                      preco: double.parse(_precoController.text),
                      estoque: int.parse(_estoqueController.text),
                    );

                    // Obtenha a instância do SharedPreferences
                    final prefs = await SharedPreferences.getInstance();

                    // Converta o novoProduto em uma string JSON
                    final produtoJson = jsonEncode(novoProduto.toMap());

                    // Obtenha a lista atual de produtos do SharedPreferences
                    List<String>? produtosJson = prefs.getStringList('produtos');

                    // Se a lista não existir, inicialize-a
                    if (produtosJson == null) {
                      produtosJson = [];
                    }

                    // Encontre o índice do produto a ser atualizado na lista
                    final index = produtosJson.indexWhere((element) => element.contains(novoProduto.id));

                    // Se o produto estiver na lista, atualize-o
                    if (index != -1) {
                      produtosJson[index] = produtoJson;
                    }

                    // Salve a lista atualizada no SharedPreferences
                    await prefs.setStringList('produtos', produtosJson);

                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Produto atualizado com sucesso!')),
                    );
                    Navigator.pop(context, true);
                  }
                },
                child: Text('Salvar'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
