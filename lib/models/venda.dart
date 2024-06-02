class Venda {
  final String id;
  final String clienteId; // Adicionado clienteId
  final String produtoId;
  final int quantidade;
  final String data;
  final double valorComIVA;
  final double valorIVA;

  Venda({
    required this.id,
    required this.clienteId, // Adicionado clienteId
    required this.produtoId,
    required this.quantidade,
    required this.data,
    required this.valorComIVA,
    required this.valorIVA,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'clienteId': clienteId, // Adicionado clienteId
      'produtoId': produtoId,
      'quantidade': quantidade,
      'data': data,
      'valorComIVA': valorComIVA,
      'valorIVA': valorIVA,
    };
  }

  static Venda fromMap(Map<String, dynamic> map) {
    return Venda(
      id: map['id'],
      clienteId: map['clienteId'], // Adicionado clienteId
      produtoId: map['produtoId'],
      quantidade: map['quantidade'],
      data: map['data'],
      valorComIVA: map['valorComIVA'],
      valorIVA: map['valorIVA'],
    );
  }
}
