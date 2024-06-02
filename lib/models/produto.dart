class Produto {
  final String id;
  final String nome;
  final String descricao;
  final double preco;
  int estoque; // Remover a keyword final para que o valor possa ser atualizado

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
}
