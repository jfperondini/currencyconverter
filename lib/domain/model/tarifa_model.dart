class TarifaModel {
  String nome;
  double valor;

  TarifaModel({
    required this.nome,
    required this.valor,
  });

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'nome': nome,
      'valor': valor,
    };
  }

  factory TarifaModel.fromJson(Map<String, dynamic> map) {
    return TarifaModel(
      nome: map['nome'] ?? '',
      valor: map['valor'] ?? 0.00,
    );
  }
}
