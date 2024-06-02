import 'package:flutter/material.dart';
import 'package:sistema_gestao_farmacia/models/cliente.dart';
import 'package:sistema_gestao_farmacia/models/transacao.dart';
import 'package:sistema_gestao_farmacia/services/transacao_service.dart';

class VerContaCorrenteScreen extends StatefulWidget {
  final Cliente cliente;

  const VerContaCorrenteScreen({Key? key, required this.cliente}) : super(key: key);

  @override
  _VerContaCorrenteScreenState createState() => _VerContaCorrenteScreenState();
}

class _VerContaCorrenteScreenState extends State<VerContaCorrenteScreen> {
  final TransacaoService transacaoService = TransacaoService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Conta Corrente de ${widget.cliente.nome}'),
      ),
      body: FutureBuilder(
        future: transacaoService.getTransacoesDoCliente(widget.cliente),
        builder: (BuildContext context, AsyncSnapshot<List<Transacao>> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Erro ao carregar as transações'));
          } else if (snapshot.hasData) {
            final transacoes = snapshot.data!;
            return _buildListaTransacoes(transacoes);
          } else {
            return Center(child: Text('Nenhuma transação encontrada'));
          }
        },
      ),
    );
  }

  Widget _buildListaTransacoes(List<Transacao> transacoes) {
    return ListView.builder(
      itemCount: transacoes.length,
      itemBuilder: (context, index) {
        final transacao = transacoes[index];
        return ListTile(
          title: Text(transacao.descricao),
          subtitle: Text(transacao.data.toString()),
          trailing: Text(transacao.valor.toStringAsFixed(2)),
        );
      },
    );
  }
}
