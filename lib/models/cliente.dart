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

  // Adicionando o método fromMap
  Cliente.fromMap(Map<String, dynamic> map) 
    : id = map['id'],
      nome = map['nome'],
      endereco = map['endereco'],
      telefone = map['telefone'],
      email = map['email'];


  // Convertendo um Cliente em um Map
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'nome': nome,
      'endereco': endereco,
      'telefone': telefone,
      'email': email,
    };
  }

  // Convertendo um Map em um Cliente
  factory Cliente.fromJson(Map<String, dynamic> json) {
    return Cliente(
      id: json['id'],
      nome: json['nome'],
      endereco: json['endereco'],
      telefone: json['telefone'],
      email: json['email'],
    );
  }
  @override
  String toString() {
    return 'Cliente{id: $id, nome: $nome, endereco: $endereco, telefone: $telefone, email: $email}';
  }
}