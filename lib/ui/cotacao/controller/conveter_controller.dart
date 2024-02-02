// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:currencyconverter/cors/shared/extension/double_extension.dart';
import 'package:currencyconverter/cors/shared/extension/string_extension.dart';
import 'package:flutter/foundation.dart';

import 'package:currencyconverter/data/service/cotacao_moeda_service.dart';
import 'package:currencyconverter/data/service/tarifa_service.dart';
import 'package:currencyconverter/domain/model/converter_moeda.dart';
import 'package:currencyconverter/domain/model/cotacao_moeda_model.dart';

class ConverterController extends ChangeNotifier {
  final CotacaoMoedaService cotacaoMoedaService;
  final TarifaService tarifaService;

  ConverterController(this.cotacaoMoedaService, this.tarifaService);

  ConverterMoedaModel? converterMoedaSelect;

  CotacaoMoedaModel? cotacaoMoedaSelect;

  setConverter({required String paises}) async {
    //Cotação
    cotacaoMoedaSelect = await cotacaoMoedaService.getByPaises(paises: paises);
    //Tarifa
    String paisesTarifa = paises.toReplaceMinusWithPlus(paises);
    cotacaoMoedaSelect?.tarifaModel = await tarifaService.getByPaises(paises: paisesTarifa);
    notifyListeners();
  }

  calculateConversao({required double valorEnviar}) async {
    double cambio = double.parse(cotacaoMoedaSelect?.ask ?? '').toPrecision(2);
    double tafira = ((valorEnviar * (cotacaoMoedaSelect?.tarifaModel.valor ?? 0.00)) / 100.0).toPrecision(2);
    double valorConvertido = (valorEnviar - tafira).toPrecision(2);
    double valorReceber = (valorConvertido * cambio).toPrecision(2);

    ConverterMoedaModel newConverterMoeda = ConverterMoedaModel(
      valorEnviar: valorEnviar,
      tarifa: tafira,
      cambio: cambio,
      valorConvertido: valorConvertido,
      valorRececer: valorReceber,
    );
    converterMoedaSelect = newConverterMoeda;
    notifyListeners();
  }
}
