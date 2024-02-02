import 'package:currencyconverter/domain/model/moeda_model.dart';

class PaisModel {
  String idPais;
  String pais;
  String foto;
  MoedaModel moedaModel;

  PaisModel({
    required this.idPais,
    required this.pais,
    required this.foto,
    required this.moedaModel,
  });

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'idPais': idPais,
      'pais': pais,
      'foto': foto,
      'moedaModel': moedaModel.toJson(),
    };
  }

  factory PaisModel.fromJson(Map<String, dynamic> map) {
    return PaisModel(
      idPais: map['idPais'] ?? '',
      pais: map['pais'] ?? '',
      foto: map['foto'] ?? '',
      moedaModel: MoedaModel.fromJson(map['moedaModel'] ?? {}),
    );
  }
}
