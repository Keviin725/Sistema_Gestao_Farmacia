import 'package:flutter/material.dart';
import 'package:sistema_gestao_farmacia/models/cliente.dart';
import 'package:sistema_gestao_farmacia/services/cliente_service.dart';
import 'dart:convert';
import 'dart:io';
import 'package:shared_preferences/shared_preferences.dart';

class AdicionarClienteScreen extends StatefulWidget {
  @override
  _AdicionarClienteScreenState createState() => _AdicionarClienteScreenState();
}

class _AdicionarClienteScreenState extends State<AdicionarClienteScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nomeController = TextEditingController();
  final _enderecoController = TextEditingController();
  final _telefoneController = TextEditingController();
  final _emailController = TextEditingController();
  final ClienteService clienteService = ClienteService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Adicionar Cliente'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              TextFormField(
                controller: _nomeController,
                decoration: InputDecoration(
                  labelText: 'Nome',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    print("Campo 'Nome' vazio");
                    return 'Por favor, insira o nome';
                  }
                  return null;
                },
              ),
              SizedBox(height: 16),
              TextFormField(
                controller: _enderecoController,
                decoration: InputDecoration(
                  labelText: 'Endereço',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    print("Campo 'Endereço' vazio");
                    return 'Por favor, insira o endereço';
                  }
                  return null;
                },
              ),
              SizedBox(height: 16),
              TextFormField(
                controller: _telefoneController,
                decoration: InputDecoration(
                  labelText: 'Telefone',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    print("Campo 'Telefone' vazio");
                    return 'Por favor, insira o telefone';
                  }
                  return null;
                },
              ),
              SizedBox(height: 16),
              TextFormField(
                controller: _emailController,
                decoration: InputDecoration(
                  labelText: 'Email',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    print("Campo 'Email' vazio");
                    return 'Por favor, insira o email';
                  }
                  return null;
                },
              ),
              SizedBox(height: 20),
              ElevatedButton(
  onPressed: () async {
  print("Botão 'Salvar' pressionado");
  if (_formKey.currentState!.validate()) {
    print("Formulário validado");
    final cliente = Cliente(
      id: DateTime.now().toString(),
      nome: _nomeController.text,
      endereco: _enderecoController.text,
      telefone: _telefoneController.text,
      email: _emailController.text,
    );
    print("Cliente criado: $cliente");

    // Salvando o cliente usando SharedPreferences
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String>? clientesJson = prefs.getStringList('clientes');
    List<Cliente> clientes = clientesJson != null ? clientesJson.map((clienteJson) => Cliente.fromMap(jsonDecode(clienteJson))).toList() : [];
    clientes.add(cliente);
    await prefs.setStringList('clientes', clientes.map((cliente) => jsonEncode(cliente.toMap())).toList());
    print("Cliente adicionado à lista e salvo no SharedPreferences");

    clienteService.insertCliente(cliente).then((value) {
      print("Cliente adicionado com sucesso");
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Cliente adicionado com sucesso')),
      );
      print("Campos do formulário limpos");
      _nomeController.clear();
      _enderecoController.clear();
      _telefoneController.clear();
      _emailController.clear();
    }).catchError((error) {
      print("Erro ao adicionar cliente: $error");
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Erro ao adicionar cliente: $error')),
      );
    });
    print("Chamada para insertCliente feita");
  } else {
    print("Formulário não validado");
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
