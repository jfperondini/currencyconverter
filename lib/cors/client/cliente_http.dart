import 'package:currencyconverter/cors/client/cliente_ihttp.dart';
import 'package:dio/dio.dart';

class ClientHttp implements ClientIHttp {
  late final Dio dio;

  ClientHttp() {
    dio = Dio(BaseOptions(connectTimeout: const Duration(seconds: 2)));
  }

  factory ClientHttp.start() {
    return ClientHttp();
  }

  @override
  Future get(String path) async {
    final response = await dio.get(path);
    return response;
  }
}
