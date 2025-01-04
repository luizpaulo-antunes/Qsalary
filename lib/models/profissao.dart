class Profissao {
  final String nome;
  final String moedaBrasil;
  final double salarioBrasil;
  final String moedaEUA;
  final double salarioEUA;

  Profissao({
    required this.nome,
    required this.moedaBrasil,
    required this.salarioBrasil,
    required this.moedaEUA,
    required this.salarioEUA,
  });

  factory Profissao.fromJson(Map<String, dynamic> json) {
    return Profissao(
      nome: json['nome'],
      moedaBrasil: json['salario_brasil']['moeda'],
      salarioBrasil: json['salario_brasil']['valor'].toDouble(),
      moedaEUA: json['salario_eua']['moeda'],
      salarioEUA: json['salario_eua']['valor'].toDouble(),
    );
  }
}
