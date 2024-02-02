# currencyconverter

Ao longo da jornada de evolução no desenvolvimento com Flutter, minha compreensão sobre a importância dos "Testes Unitários" cresceu substancialmente.

Atualmente, compreendo que a execução de testes é essencial para assegurar o funcionamento adequado de cada componente do meu projeto.

A sinergia entre testes unitários, mocks e simulações de serviços clientes não apenas verifica a integridade do código, mas também eleva a qualidade do software a um nível superior.

Essa abordagem robusta não só valida a funcionalidade, mas também contribui para a excelência global do projeto.

## Porque Test Unitario?

Ao considerar a importância dos Testes Unitários, destacam-se cinco tópicos relevantes que evidenciam sua relevância no desenvolvimento de software:

1. Garantia de Isolamento e Independência.
2. Simulação de Comportamento.
3. Rapidez e Eficiência nos Testes.
4. Prevenção de Problemas Futuros.
5. Melhoria da Manutenibilidade.

## Testando

Primeiramente, realizei testes utilizando dados mockados para obter informações sobre um único país e sua moeda. Essa prática é comum para verificar se o código está funcionando conforme o esperado, sem depender de dados reais.

```dart

class DioMock extends Mock implements Dio {}

class IHttpClientMock extends Mock implements ClientIHttp {}

// Criar um mock do cliente HTTP
final clientMock = IHttpClientMock();

// Criar um cliente HTTP
final clientHttp = ClientHttp();

// Criar uma instância do serviço do cliente HTTP
final serviceCotacaoMoeda = CotacaoMoedaService(clientHttp);

void main() {
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
```

O JSON a seguir mostra o resultado esperado após a execução do código de teste.

```json
{
  "idPais": "3",
  "pais": "Áustria",
  "foto": "austria.svg",
  "moedaModel": {
    "idMoeda": "9",
    "nome": "Euro",
    "sigla": "EUR",
    "formato": "€",
    "foto": "euro.svg"
  }
}
```

Em seguida, realizei testes com dados provenientes de um cliente (Client) com dados Mockados para obter informações sobre uma moeda e sua tarifa.

```dart

class DioMock extends Mock implements Dio {}

class IHttpClientMock extends Mock implements ClientIHttp {}

// Criar um mock do cliente HTTP
final clientMock = IHttpClientMock();

// Criar um cliente HTTP
final clientHttp = ClientHttp();

// Criar uma instância do serviço do cliente HTTP
final serviceCotacaoMoeda = CotacaoMoedaService(clientHttp);

void main() {
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
```

O JSON a seguir mostra o resultado esperado após a execução do código de teste com dados do Client.

```json
{
  "code": "CAD",
  "codein": "BRL",
  "name": "Dólar Canadense/Real Brasileiro",
  "bid": "3.6769",
  "ask": "3.6824",
  "create_date": "2024-01-23 15:20:36",
  "tarifaModel": { "nome": "CADBRL", "valor": 1.56 }
}
```

Esses testes foram realizados para garantir o correto funcionamento do código em diferentes cenários, usando tanto dados mockados quanto dados provenientes de um cliente real.

## Extra

Além dos testes unitários realizados anteriormente, é importante abordar os testes de um controller, que é responsável por orquestrar as interações entre diferentes partes do sistema.

```dart
  setConverter({required String paises}) async {
    //Cotação
    cotacaoMoedaSelect = await cotacaoMoedaService.getByPaises(paises: paises);
    //Tarifa
    String paisesTarifa = paises.toReplaceMinusWithPlus(paises);
    cotacaoMoedaSelect?.tarifaModel = await tarifaService.getByPaises(paises: paisesTarifa);
    notifyListeners();
  }
```

```dart
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
```

```dart
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
```

O JSON a seguir mostra o resultado esperado após a execução do código de teste com dados que podem ser exibidos em uma tela para a conversão de uma moeda para outra.

```json
[
  {
    "code": "CAD",
    "codein": "BRL",
    "name": "Dólar Canadense/Real Brasileiro",
    "bid": "3.6769",
    "ask": "3.6824",
    "create_date": "2024-01-23 15:20:36",
    "tarifaModel": { "nome": "CADBRL", "valor": 1.56 }
  },
  {
    "valorEnviar": 1000.0,
    "tarifa": 15.6,
    "valorConvertido": 984.4,
    "cambio": 3.68,
    "valorRececer": 3622.59
  }
]
```

Estes testes garantem que o controller interage corretamente com os serviços de moeda e conversão, proporcionando assim uma cobertura mais abrangente para a funcionalidade de conversão de moeda.
