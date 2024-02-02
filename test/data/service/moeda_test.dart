// ignore_for_file: avoid_print
import 'dart:convert';
import 'package:currencyconverter/cors/client/cliente_http.dart';
import 'package:currencyconverter/cors/client/cliente_ihttp.dart';
import 'package:currencyconverter/cors/mocks/tarifa_mock.dart';
import 'package:currencyconverter/data/service/cotacao_moeda_service.dart';
import 'package:currencyconverter/data/service/tarifa_service.dart';
import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class DioMock extends Mock implements Dio {}

class IHttpClientMock extends Mock implements ClientIHttp {}

// Criar um mock do cliente HTTP
final clientMock = IHttpClientMock();

// Criar um cliente HTTP
final clientHttp = ClientHttp();

// Criar uma instância do serviço do cliente HTTP
final serviceCotacaoMoeda = CotacaoMoedaService(clientHttp);

void main() {
  test('deve retornar cotacao da moeda com a tarifa', () async {
    // Chamar a função que busca o dado via idPais
    final cotacao = await serviceCotacaoMoeda.getByPaises(paises: 'CAD-BRL');

    // Configurar o mock para retornar os dados fornecidos quando a função get é chamada
    when(() => clientMock.get(any())).thenAnswer((_) async => jsonEncode([tarifaMock]));

    // Criar uma instância do serviço com o mock do cliente HTTP
    final serviceTarifa = TarifaService(clientMock);

    // Chamar a função que busca os dados via siglas
    cotacao.tarifaModel = await serviceTarifa.getByPaises(paises: 'CADBRL');

    // Verificar se o resultado é o esperado
    final formattedJson = json.encode(cotacao);

    // Imprime o JSON formatado para verificação manual
    print(formattedJson);
  });

  test('deve retornar cotacao da moeda por um periodo especifico', () async {
    // Chamar a função que busca o dado via idPais
    final cotacao = await serviceCotacaoMoeda.getByPeriodo(
      paises: 'CAD-BRL',
      dataIncial: '20240101',
      dataFinal: '20240120',
    );
    // Verificar se o resultado é o esperado
    final formattedJson = json.encode(cotacao);

    // Imprime o JSON formatado para verificação manual
    print(formattedJson);
  });
}
