import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

import '../models/profissao.dart';
import '../services/profissao_service.dart';

class TelaPrincipal extends StatefulWidget {
  const TelaPrincipal({super.key});

  @override
  State<TelaPrincipal> createState() => _TelaPrincipalState();
}

class _TelaPrincipalState extends State<TelaPrincipal> {
  final ProfissaoService _profissaoService = ProfissaoService();
  List<Profissao> _profissoes = [];
  int _selectedIndex = 0; // Índice da aba selecionada

  @override
  void initState() {
    super.initState();
    _carregarDados();
  }

  Future<void> _carregarDados() async {
    _profissoes = await _profissaoService.lerDadosJson();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Salarios na TI'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(height: 20),
            Expanded(
              child: CarouselSlider(
                options: CarouselOptions(
                  height: 250.0,
                  enlargeCenterPage: true,
                  autoPlay: true,
                  aspectRatio: 16 / 9,
                  autoPlayCurve: Curves.slowMiddle,
                  enableInfiniteScroll: true,
                  autoPlayAnimationDuration: const Duration(milliseconds: 800),
                  viewportFraction: 0.8,
                ),
                items: _profissoes.map((profissao) {
                  return Builder(
                    builder: (BuildContext context) {
                      return Container(
                        width: MediaQuery.of(context).size.width,
                        margin: const EdgeInsets.symmetric(horizontal: 5.0),
                        decoration: const BoxDecoration(),
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                iconesProfissoes[profissao.nome],
                                size: 48,
                              ),
                              const SizedBox(height: 8),
                              Text(
                                profissao.nome,
                                style: const TextStyle(fontSize: 18.0),
                                textAlign: TextAlign.center,
                              ),
                              const SizedBox(height: 8),
                              Text(
                                'Salário Brasil: ${profissao.moedaBrasil} ${profissao.salarioBrasil}',
                                style: const TextStyle(fontSize: 16.0),
                              ),
                              Text(
                                'Salário EUA: ${profissao.moedaEUA} ${profissao.salarioEUA}',
                                style: const TextStyle(fontSize: 16.0),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  );
                }).toList(),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: NavigationBar(
        selectedIndex: _selectedIndex,
        onDestinationSelected: (int index) {
          setState(() {
            _selectedIndex = index;
          });
        },
        destinations: const <Widget>[
          NavigationDestination(
            selectedIcon: Icon(Icons.home),
            icon: Icon(Icons.home_outlined),
            label: 'Home',
          ),
          NavigationDestination(
            selectedIcon: Icon(Icons.business),
            icon: Icon(Icons.business_outlined),
            label: 'Skills',
          ),
          NavigationDestination(
            selectedIcon: Icon(Icons.school),
            icon: Icon(Icons.school_outlined),
            label: 'Cursos',
          ),
        ],
      ),
    );
  }

  Map<String, IconData> iconesProfissoes = {
    'Desenvolvedor(a) de Software': Icons.code,
    'Engenheiro(a) de Software': Icons.engineering,
    'Analista de Sistemas': Icons.computer,
    'Programador(a)': Icons.laptop_chromebook,
    'Desenvolvedor(a) Front-End': Icons.web,
    'Desenvolvedor(a) Back-End': Icons.storage,
    'Analista de Testes': Icons.bug_report,
    'Analista de Qualidade (QA)': Icons.verified_user,
    'Scrum Master': Icons.groups,
    'Product Owner (PO)': Icons.person,
    'Arquiteto(a) de Software': Icons.architecture,
    'Analista DevOps': Icons.cloud,
    'Designer de UX/UI': Icons.design_services,
    'Engenheiro(a) de Dados': Icons.data_exploration,
    'Cientista de Dados': Icons.science,
  };
}
