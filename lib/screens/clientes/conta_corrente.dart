import 'package:flutter/material.dart';
import 'package:sistema_gestao_farmacia/models/cliente.dart';
import 'package:sistema_gestao_farmacia/models/transacao.dart'; // Importe Transacao
import 'package:sistema_gestao_farmacia/services/transacao_service.dart';

class VerContaCorrenteScreen extends StatefulWidget {


  @override
  _VerContaCorrenteScreenState createState() => _VerContaCorrenteScreenState();
}

class _VerContaCorrenteScreenState extends State<VerContaCorrenteScreen> {
  final TransacaoService transacaoService = TransacaoService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Conta Corrente de 20MZN'),
      ),
      
    );
  }

  
}
