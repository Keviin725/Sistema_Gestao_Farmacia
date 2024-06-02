import 'package:flutter/material.dart';
import 'package:sistema_gestao_farmacia/models/produto.dart';
import 'package:sistema_gestao_farmacia/services/produto_service.dart';

class NovaVendaScreen extends StatefulWidget {
  @override
  _NovaVendaScreenState createState() => _NovaVendaScreenState();
}

class _NovaVendaScreenState extends State<NovaVendaScreen> {
  final _produtoService = ProdutoService();
  List<Produto> _produtos = [];
  Produto? _produtoSelecionado;
  int _quantidadeSelecionada = 1;
  List<Produto> _itensAdicionados = [];

  @override
  void initState() {
    super.initState();
    _carregarProdutos();
  }

  Future<void> _carregarProdutos() async {
    final produtos = await _produtoService.getProdutos();
    setState(() {
      _produtos = produtos;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Nova Venda'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Selecione o produto:',
              style: TextStyle(fontSize: 18),
            ),
            SizedBox(height: 10),
            DropdownButtonFormField<Produto>(
              value: _produtoSelecionado,
              items: _produtos.map((produto) {
                return DropdownMenuItem<Produto>(
                  value: produto,
                  child: Text(produto.nome),
                );
              }).toList(),
              onChanged: (produto) {
                setState(() {
                  _produtoSelecionado = produto;
                });
              },
              decoration: InputDecoration(
                labelText: 'Produto',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 10),
            Text(
              'Quantidade:',
              style: TextStyle(fontSize: 18),
            ),
            SizedBox(height: 10),
            Row(
              children: [
                IconButton(
                  icon: Icon(Icons.remove),
                  onPressed: () {
                    setState(() {
                      if (_quantidadeSelecionada > 1) {
                        _quantidadeSelecionada--;
                      }
                    });
                  },
                ),
                Text(
                  '$_quantidadeSelecionada',
                  style: TextStyle(fontSize: 18),
                ),
                IconButton(
                  icon: Icon(Icons.add),
                  onPressed: () {
                    setState(() {
                      _quantidadeSelecionada++;
                    });
                  },
                ),
              ],
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                if (_produtoSelecionado != null) {
                  setState(() {
                    _itensAdicionados.add(_produtoSelecionado!);
                    _produtoSelecionado = null;
                    _quantidadeSelecionada = 1;
                  });
                }
              },
              child: Text('Adicionar à Venda'),
            ),
            SizedBox(height: 20),
            Text(
              'Itens Adicionados:',
              style: TextStyle(fontSize: 18),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: _itensAdicionados.length,
                itemBuilder: (context, index) {
                  final produto = _itensAdicionados[index];
                  return ListTile(
                    title: Text(produto.nome),
                    subtitle: Text('Quantidade: $_quantidadeSelecionada'),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
