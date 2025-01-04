import 'dart:convert';
import 'package:flutter/services.dart';
import '../models/profissao.dart';

class ProfissaoService {
  Future<List<Profissao>> lerDadosJson() async {
    final String jsonString = await rootBundle.loadString('assets/dados.json');
    final jsonData = jsonDecode(jsonString);
    final List<dynamic> profissoesJson = jsonData['profissoes'];
    return profissoesJson.map((json) => Profissao.fromJson(json)).toList();
  }
}
