import 'package:flutter/material.dart';
import 'package:sistema_gestao_farmacia/models/produto.dart';
import 'package:sistema_gestao_farmacia/services/produto_service.dart';
import 'package:sistema_gestao_farmacia/services/venda_service.dart';
import 'package:sistema_gestao_farmacia/models/venda.dart';

class NovaVendaScreen extends StatefulWidget {
  @override
  _NovaVendaScreenState createState() => _NovaVendaScreenState();
}

class _NovaVendaScreenState extends State<NovaVendaScreen> {
  final _produtoService = ProdutoService();
  final _vendaService = VendaService();
  List<Produto> _produtos = [];
  Produto? _produtoSelecionado;
  int _quantidadeSelecionada = 1;
  double _ivaSelecionado = 0.23; // Taxa de IVA padrão

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

  double _calcularValorComIVA(double valorSemIVA) {
    return valorSemIVA * (1 + _ivaSelecionado);
  }

  double _calcularValorIVA(double valorSemIVA) {
    return valorSemIVA * _ivaSelecionado;
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
            SizedBox(height: 10),
            Text(
              'Taxa de IVA:',
              style: TextStyle(fontSize: 18),
            ),
            SizedBox(height: 10),
            DropdownButtonFormField<double>(
              value: _ivaSelecionado,
              items: [0.06, 0.13, 0.23].map((iva) {
                return DropdownMenuItem<double>(
                  value: iva,
                  child: Text('${iva * 100}%'),
                );
              }).toList(),
              onChanged: (iva) {
                setState(() {
                  _ivaSelecionado = iva!;
                });
              },
              decoration: InputDecoration(
                labelText: 'Taxa de IVA',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                if (_produtoSelecionado != null && _produtoSelecionado!.estoque >= _quantidadeSelecionada) {
                  final venda = Venda(
                    id: DateTime.now().toString(),
                    produtoId: _produtoSelecionado!.id,
                    quantidade: _quantidadeSelecionada,
                    data: DateTime.now().toString(),
                  );
                  _vendaService.inserirVenda(venda);
                  setState(() {
                    _produtoSelecionado!.estoque -= _quantidadeSelecionada;
                  });
                  Navigator.pop(context, true);
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Quantidade em estoque insuficiente ou produto não selecionado!')),
                  );
                }
              },
              child: Text('Salvar'),
            ),
          ],
        ),
      ),
    );
  }
}
