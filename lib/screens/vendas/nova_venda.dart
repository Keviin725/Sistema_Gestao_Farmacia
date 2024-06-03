import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:sistema_gestao_farmacia/models/produto.dart';
import 'package:sistema_gestao_farmacia/models/venda.dart';
import 'package:sistema_gestao_farmacia/models/cliente.dart';
import 'package:shared_preferences/shared_preferences.dart';

class NovaVendaScreen extends StatefulWidget {
  @override
  _NovaVendaScreenState createState() => _NovaVendaScreenState();
}

class _NovaVendaScreenState extends State<NovaVendaScreen> {
  List<Produto> _produtos = [];
  List<Cliente> _clientes = [];
  Produto? _produtoSelecionado;
  Cliente? _clienteSelecionado;
  int _quantidadeSelecionada = 1;
  double _ivaSelecionado = 0.23;

  @override
  void initState() {
    super.initState();
    _carregarProdutos();
    _carregarClientes();
  }

  Future<void> _carregarProdutos() async {
    final prefs = await SharedPreferences.getInstance();
    final produtosJson = prefs.getStringList('produtos') ?? [];
    setState(() {
      _produtos = produtosJson.map((produto) => Produto.fromJson(jsonDecode(produto))).toList();
    });
  }

  Future<void> _carregarClientes() async {
    final prefs = await SharedPreferences.getInstance();
    final clientesJson = prefs.getStringList('clientes') ?? [];
    setState(() {
      _clientes = clientesJson.map((cliente) => Cliente.fromJson(jsonDecode(cliente))).toList();
    });
  }

  Future<void> _atualizarProduto(Produto produto) async {
    final prefs = await SharedPreferences.getInstance();
    final produtosJson = prefs.getStringList('produtos') ?? [];
    final index = produtosJson.indexWhere((produtoJson) => Produto.fromJson(jsonDecode(produtoJson)).id == produto.id);
    if (index != -1) {
      produtosJson[index] = jsonEncode(produto.toJson());
      await prefs.setStringList('produtos', produtosJson);
    }
  }

  double _calcularValorComIVA(double valorSemIVA) {
    return valorSemIVA * (1 + _ivaSelecionado);
  }

  double _calcularValorIVA(double valorSemIVA) {
    return valorSemIVA * _ivaSelecionado;
  }

  Future<void> _inserirVenda(Venda venda) async {
    final prefs = await SharedPreferences.getInstance();
    final vendas = prefs.getStringList('vendas') ?? [];
    vendas.add(jsonEncode(venda.toJson()));
    await prefs.setStringList('vendas', vendas);
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
              'Selecionar Cliente',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            DropdownButton<Cliente>(
              value: _clienteSelecionado,
              hint: Text('Selecione um cliente'),
              isExpanded: true,
              items: _clientes.map((Cliente cliente) {
                return DropdownMenuItem<Cliente>(
                  value: cliente,
                  child: Text(cliente.nome),
                );
              }).toList(),
              onChanged: (Cliente? novoClienteSelecionado) {
                setState(() {
                  _clienteSelecionado = novoClienteSelecionado;
                });
              },
            ),
            SizedBox(height: 20),
            Text(
              'Selecionar Produto',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            DropdownButton<Produto>(
              value: _produtoSelecionado,
              hint: Text('Selecione um produto'),
              isExpanded: true,
              items: _produtos.map((Produto produto) {
                return DropdownMenuItem<Produto>(
                  value: produto,
                  child: Text(produto.nome),
                );
              }).toList(),
              onChanged: (Produto? novoProdutoSelecionado) {
                setState(() {
                  _produtoSelecionado = novoProdutoSelecionado;
                });
              },
            ),
            SizedBox(height: 20),
            Text(
              'Quantidade',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
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
                if (_clienteSelecionado != null && _produtoSelecionado != null && _produtoSelecionado!.estoque >= _quantidadeSelecionada) {
                  final valorSemIVA = _produtoSelecionado!.preco * _quantidadeSelecionada;
                  final valorComIVA = _calcularValorComIVA(valorSemIVA);
                  final valorIVA = _calcularValorIVA(valorSemIVA);

                  final venda = Venda(
                    id: DateTime.now().toString(),
                    clienteId: _clienteSelecionado!.id,
                    produtoId: _produtoSelecionado!.id,
                    quantidade: _quantidadeSelecionada,
                    data: DateTime.now().toString(),
                    valorComIVA: valorComIVA,
                    valorIVA: valorIVA,
                  );
                  _inserirVenda(venda);
                  setState(() {
                    _produtoSelecionado!.estoque -= _quantidadeSelecionada;
                  });
                  _atualizarProduto(_produtoSelecionado!);
                  Navigator.pop(context, true);
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Cliente, produto não selecionado ou quantidade em estoque insuficiente!')),
                  );
                }
              },
              child: Text('Salvar'),
            ),
            SizedBox(height: 20),
            if (_produtoSelecionado != null)
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Detalhes da Venda',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 10),
                  Text('Produto: ${_produtoSelecionado!.nome}'),
                  Text('Quantidade: $_quantidadeSelecionada'),
                  Text('Valor sem IVA: MZN${(_produtoSelecionado!.preco * _quantidadeSelecionada).toStringAsFixed(2)}'),
                  Text('Valor do IVA: MZN${_calcularValorIVA(_produtoSelecionado!.preco * _quantidadeSelecionada).toStringAsFixed(2)}'),
                  Text('Valor com IVA: MZN${_calcularValorComIVA(_produtoSelecionado!.preco * _quantidadeSelecionada).toStringAsFixed(2)}'),
                ],
              ),
          ],
        ),
      ),
    );
  }
}
