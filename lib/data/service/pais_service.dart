import 'package:currencyconverter/cors/client/cliente_ihttp.dart';
import 'package:currencyconverter/cors/mocks/pais_mock.dart';
import 'package:currencyconverter/domain/model/pais_model.dart';

class PaisService {
  final ClientIHttp client;

  PaisService(this.client);

  Future<List<PaisModel>> getList() async {
    final result = paisMock;
    return result.map((e) => PaisModel.fromJson(e)).toList();
  }

  Future<PaisModel?> getById({required String idPais}) async {
    final result = paisMock;
    final filtro = result.where((e) => e['idPais'] == idPais).toList();
    return PaisModel.fromJson(filtro.first);
  }
}
