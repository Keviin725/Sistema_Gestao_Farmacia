class Produto {
  final String id;
  final String nome;
  final String descricao;
  final double preco;
  int estoque;

  Produto({
    required this.id,
    required this.nome,
    required this.descricao,
    required this.preco,
    required this.estoque,
  });

  void atualizarEstoque(int quantidade) {
    estoque -= quantidade;
    if (estoque < 0) {
      estoque = 0;
    }
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'nome': nome,
      'descricao': descricao,
      'preco': preco,
      'estoque': estoque,
    };
  }

  static Produto fromMap(Map<String, dynamic> map) {
    return Produto(
      id: map['id'],
      nome: map['nome'],
      descricao: map['descricao'],
      preco: map['preco'],
      estoque: map['estoque'],
    );
  }
  static Produto fromJson(Map<String, dynamic> json) {
    return Produto(
      id: json['id'],
      nome: json['nome'],
      descricao: json['descricao'],
      preco: json['preco'],
      estoque: json['estoque'],
    );
  }

   Map<String, dynamic> toJson() {
    return {
      'id': id,
      'nome': nome,
      'descricao': descricao,
      'preco': preco,
      'estoque': estoque,
    };
  }
  
}
