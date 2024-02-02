import 'package:currencyconverter/domain/model/tarifa_model.dart';

class CotacaoMoedaModel {
  String code;
  String codeIn;
  String name;
  String bid;
  String ask;
  String createDate;
  TarifaModel tarifaModel;

  CotacaoMoedaModel({
    required this.code,
    required this.codeIn,
    required this.name,
    required this.bid,
    required this.ask,
    required this.createDate,
    required this.tarifaModel,
  });

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'code': code,
      'codein': codeIn,
      'name': name,
      'bid': bid,
      'ask': ask,
      'create_date': createDate,
      'tarifaModel': tarifaModel.toJson(),
    };
  }

  factory CotacaoMoedaModel.fromJson(Map<String, dynamic> map) {
    return CotacaoMoedaModel(
      code: map['code'] ?? '',
      codeIn: map['codein'] ?? '',
      name: map['name'] ?? '',
      bid: map['bid'] ?? '',
      ask: map['ask'] ?? '',
      createDate: map['create_date'] ?? '',
      tarifaModel: TarifaModel.fromJson(map['tarifaModel'] ?? {}),
    );
  }
}
