class Venda {
  final String id;
  final String produtoId;
  final int quantidade;
  final String data;
  final double valorComIVA;
  final double valorIVA;

  Venda({
    required this.id,
    required this.produtoId,
    required this.quantidade,
    required this.data,
    required this.valorComIVA,
    required this.valorIVA,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'produtoId': produtoId,
      'quantidade': quantidade,
      'data': data,
      'valorComIVA': valorComIVA,
      'valorIVA': valorIVA,
    };
  }
}
