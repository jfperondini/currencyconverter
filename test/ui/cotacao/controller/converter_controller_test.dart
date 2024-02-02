// ignore_for_file: avoid_print

import 'dart:convert';

import 'package:currencyconverter/cors/client/cliente_http.dart';
import 'package:currencyconverter/cors/client/cliente_ihttp.dart';
import 'package:currencyconverter/cors/mocks/tarifa_mock.dart';
import 'package:currencyconverter/data/service/cotacao_moeda_service.dart';
import 'package:currencyconverter/data/service/tarifa_service.dart';
import 'package:currencyconverter/ui/cotacao/controller/conveter_controller.dart';
import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class DioMock extends Mock implements Dio {}

class IHttpClientMock extends Mock implements ClientIHttp {}

void main() {
  test('deve retornar a converção da moeda', () async {
    // Criar um mock do cliente HTTP
    final clientMock = IHttpClientMock();
    final clientHttp = ClientHttp();
    // Configurar o mock para retornar os dados fornecidos quando a função get é chamada
    when(() => clientMock.get(any())).thenAnswer((_) async => jsonEncode(tarifaMock));
    // Criar uma instância do serviço com o mock do cliente HTTP
    final tarifaService = TarifaService(clientMock);
    final cotacaoMoedaService = CotacaoMoedaService(clientHttp);
    // Criar uma instância do Controller para atribuir os serviços
    final controller = ConverterController(cotacaoMoedaService, tarifaService);
    // Chamar a função do controller
    await controller.setConverter(paises: 'CAD-BRL');
    // Verificar se o resultado é o esperado
    final formattedJsonConverter = json.encode(controller.cotacaoMoedaSelect);
    // Imprime o JSON formatado para verificação manual
    print(formattedJsonConverter);
    // Chamar a função do controller
    await controller.calculateConversao(valorEnviar: 1000);
    // Imprime o JSON formatado para verificação manual
    final formattedJsonCalcular = json.encode(controller.converterMoedaSelect);
    // Imprime o JSON formatado para verificação manual
    print(formattedJsonCalcular);
  });
}
