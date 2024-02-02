import 'package:currencyconverter/cors/client/cliente_ihttp.dart';
import 'package:currencyconverter/domain/model/cotacao_moeda_model.dart';

class CotacaoMoedaService {
  final baseUrl = 'https://economia.awesomeapi.com.br';

  final ClientIHttp client;

  CotacaoMoedaService(this.client);

  Future<CotacaoMoedaModel> getByPaises({required String paises}) async {
    final response = await client.get('$baseUrl/json/daily/$paises');
    final result = response.data as List;
    return result.map((e) => CotacaoMoedaModel.fromJson(e)).toList().first;
  }

  Future<List<CotacaoMoedaModel>> getByPeriodo(
      {required String paises, required String dataIncial, required String dataFinal}) async {
    final response = await client.get('$baseUrl/$paises/10?start_date=$dataIncial&end_date=$dataFinal');
    final result = response.data as List;
    return result.map((e) => CotacaoMoedaModel.fromJson(e)).toList();
  }
}
