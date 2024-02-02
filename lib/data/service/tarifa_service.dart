import 'package:currencyconverter/cors/client/cliente_ihttp.dart';
import 'package:currencyconverter/cors/mocks/tarifa_mock.dart';
import 'package:currencyconverter/domain/model/tarifa_model.dart';

class TarifaService {
  final ClientIHttp client;

  TarifaService(this.client);

  Future<TarifaModel> getByPaises({required String paises}) async {
    final result = tarifaMock;
    final filtro = result.where((e) => e['nome'] == paises).toList();
    return TarifaModel.fromJson(filtro.first);
  }
}
