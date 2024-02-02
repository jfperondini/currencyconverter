// ignore_for_file: avoid_print

import 'dart:convert';

import 'package:currencyconverter/cors/client/cliente_ihttp.dart';
import 'package:currencyconverter/cors/mocks/pais_mock.dart';
import 'package:currencyconverter/data/service/moeda_service.dart';
import 'package:currencyconverter/data/service/pais_service.dart';
import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class DioMock extends Mock implements Dio {}

class IHttpClientMock extends Mock implements ClientIHttp {}

// Criar um mock do cliente HTTP
final clientMock = IHttpClientMock();

// Criar uma instância do serviço com o mock do cliente HTTP
final servicePais = PaisService(clientMock);
final serviceMoeda = MoedaService(clientMock);

void main() {
  test('deve retornar todos paises', () async {
    // Configurar o mock para retornar os dados fornecidos quando a função get é chamada
    when(() => clientMock.get(any())).thenAnswer((_) async => jsonEncode(paisMock));

    // Criar uma instância do serviço com o mock do cliente HTTP

    // Chamar a função que busca os dados
    final result = await servicePais.getList();

    // Verificar se o resultado é o esperado
    final formattedJson = json.encode(result.map((pais) => pais.toJson()).toList());

    // Imprime o JSON formatado para verificação manual
    print(formattedJson);
  });

  test('deve retornar unico pais com sua moeda', () async {
    // Configurar o mock para retornar os dados fornecidos quando a função get é chamada
    when(() => clientMock.get(any())).thenAnswer((_) async => jsonEncode([paisMock]));

    // Chamar a função que busca o dado via idPais
    final pais = await servicePais.getById(idPais: '3');

    // Chamar a função que busca o dado via o idPais
    pais?.moedaModel = await serviceMoeda.getById(idPais: pais.idPais);

    // Verificar se o resultado é o esperado
    final formattedJson = json.encode(pais);

    // Imprime o JSON formatado para verificação manual
    print(formattedJson);
  });
}
