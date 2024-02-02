class MoedaModel {
  String idMoeda;
  String nome;
  String sigla;
  String formato;
  String foto;

  MoedaModel({
    required this.idMoeda,
    required this.nome,
    required this.sigla,
    required this.formato,
    required this.foto,
  });

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'idMoeda': idMoeda,
      'nome': nome,
      'sigla': sigla,
      'formato': formato,
      'foto': foto,
    };
  }

  factory MoedaModel.fromJson(Map<String, dynamic> map) {
    return MoedaModel(
      idMoeda: map['idMoeda'] ?? '',
      nome: map['nome'] ?? '',
      sigla: map['sigla'] ?? '',
      formato: map['formato'] ?? '',
      foto: map['foto'] ?? '',
    );
  }
}
