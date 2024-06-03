import 'package:flutter/material.dart';
import 'package:sistema_gestao_farmacia/models/produto.dart';
import 'package:sistema_gestao_farmacia/services/produto_service.dart';

class AdicionarProdutoScreen extends StatefulWidget {
  @override
  _AdicionarProdutoScreenState createState() => _AdicionarProdutoScreenState();
}

class _AdicionarProdutoScreenState extends State<AdicionarProdutoScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nomeController = TextEditingController();
  final _descricaoController = TextEditingController();
  final _precoController = TextEditingController();
  final _estoqueController = TextEditingController();
  final ProdutoService produtoService = ProdutoService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Adicionar Produto'),
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
                  labelText: 'Estoque',
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
        id: DateTime.now().toString(),
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

      // Adicione o novoProduto à lista
      produtosJson.add(produtoJson);

      // Salve a lista atualizada no SharedPreferences
      await prefs.setStringList('produtos', produtosJson);

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
