class Cliente {
  final String id;
  final String nome;
  final String endereco;
  final String telefone;
  final String email;

  Cliente({
    required this.id,
    required this.nome,
    required this.endereco,
    required this.telefone,
    required this.email,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'nome': nome,
      'endereco': endereco,
      'telefone': telefone,
      'email': email,
    };
  }
}
