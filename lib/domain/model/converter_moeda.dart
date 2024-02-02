class ConverterMoedaModel {
  double valorEnviar;
  double tarifa;
  double cambio;
  double valorConvertido;
  double valorRececer;

  ConverterMoedaModel({
    required this.valorEnviar,
    required this.tarifa,
    required this.cambio,
    required this.valorConvertido,
    required this.valorRececer,
  });

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'valorEnviar': valorEnviar,
      'tarifa': tarifa,
      'valorConvertido': valorConvertido,
      'cambio': cambio,
      'valorRececer': valorRececer,
    };
  }

  factory ConverterMoedaModel.fromJson(Map<String, dynamic> map) {
    return ConverterMoedaModel(
      valorEnviar: map['valorEnviar'] ?? 0.0,
      tarifa: map['tarifa'] ?? 0.0,
      valorConvertido: map['valorConvertido'] ?? 0.0,
      cambio: map['cambio'] ?? 0.0,
      valorRececer: map['valorRececer'] ?? 0.0,
    );
  }
}
