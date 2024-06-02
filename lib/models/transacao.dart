class Transacao {
  final String id;
  final String clienteId;
  final String descricao;
  final double valor;
  final DateTime data;

  Transacao({
    required this.id,
    required this.clienteId,
    required this.descricao,
    required this.valor,
    required this.data,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'cliente_id': clienteId,
      'descricao': descricao,
      'valor': valor,
      'data': data.toIso8601String(),
    };
  }

  factory Transacao.fromMap(Map<String, dynamic> map) {
    return Transacao(
      id: map['id'],
      clienteId: map['cliente_id'],
      descricao: map['descricao'],
      valor: map['valor'],
      data: DateTime.parse(map['data']),
    );
  }
}
