class Transacao {
  final String id;
  final String clienteId;
  final String descricao;
  final DateTime data;
  final double valor;

  Transacao({
    required this.id,
    required this.clienteId,
    required this.descricao,
    required this.data,
    required this.valor,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'clienteId': clienteId,
      'descricao': descricao,
      'data': data.toIso8601String(),
      'valor': valor,
    };
  }

  static Transacao fromMap(Map<String, dynamic> map) {
    return Transacao(
      id: map['id'],
      clienteId: map['clienteId'],
      descricao: map['descricao'],
      data: DateTime.parse(map['data']),
      valor: map['valor'],
    );
  }
}
