import 'package:currencyconverter/cors/client/cliente_ihttp.dart';
import 'package:currencyconverter/cors/mocks/moeda_mock.dart';
import 'package:currencyconverter/domain/model/moeda_model.dart';

class MoedaService {
  final ClientIHttp client;

  MoedaService(this.client);

  Future<MoedaModel> getById({required String idPais}) async {
    final result = moedaMock;
    return result.where((e) => (e['pais'] as List).contains(idPais)).map((e) => MoedaModel.fromJson(e)).toList().first;
  }
}
