class Produto {
  final String id;
  final String nome;
  final String descricao;
  final double preco;
  final int estoque;

  Produto({
    required this.id,
    required this.nome,
    required this.descricao,
    required this.preco,
    required this.estoque,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'nome': nome,
      'descricao': descricao,
      'preco': preco,
      'estoque': estoque,
    };
  }
}
