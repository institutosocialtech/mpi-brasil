import 'package:flutter/material.dart';
import 'package:introduction_screen/introduction_screen.dart';

class OnboardingScreen extends StatelessWidget {
  final pages = [
    // sobre a app
    PageViewModel(
      title: 'O que é o MPI Brasil?',
      body:
          'É um instrumento de busca de informações sobre medicamentos potencialmente inapropriados para idosos (MPI) disponíveis no Brasil, baseados em evidências científicas.',
      image: Center(child: Image.asset('assets/undraw/mobile_app.png', height: 175)),
    ),

    // finalidade
    PageViewModel(
      title: 'Qual a nossa finalidade?',
      body:
          'Buscamos auxiliar profissionais de saúde na tomada de decisão clínica e na realização da escolha do medicamento mais apropriado para cada doença específica e para cada paciente em particular.',
      image: Center(child: Image.asset('assets/undraw/doctors.png', height: 175)),
    ),

    // medicamentos
    PageViewModel(
      title: 'Medicamentos Inapropriados',
      body:
          'Acesse as principais informações sobre MPI de acordo com a condição clinica do paciente, com orientações de desprescrição e alternativas terapêuticas mais seguras.',
      image: Center(child: Image.asset('assets/undraw/medical_care.png', height: 175)),
    ),

    PageViewModel(
      title: 'E se o MPI for necessário?',
      body: 'Se mesmo assim, o uso do medicamento inapropriado for necessário, obtenha informações de monitoramento para tornar a farmacoterapia mais segura!',
      image: Center(child: Image.asset('assets/undraw/medicine.png', height: 175)),
    ),

    // glossario
    PageViewModel(
      title: 'Ficou com dúvida?',
      body: 'Consulte a FAQ no menu principal do aplicativo.',
      image: Center(child: Image.asset('assets/undraw/questions.png', height: 175)),
    ),

    // fim
    PageViewModel(
      title: 'Pronto!',
      body: 'Agora você pode utilizar o nosso aplicativo.',
      image: Center(child: Image.asset('assets/undraw/chore_list.png', height: 175)),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return IntroductionScreen(
      pages: pages,
      done: Text("Iniciar", style: TextStyle(fontWeight: FontWeight.bold),),
      globalBackgroundColor: Colors.white,
      dotsDecorator: DotsDecorator(
        size: const Size.square(10.0),
        activeSize: const Size(30.0, 10.0),
        activeColor: Colors.green,
        color: Colors.black12,
        spacing: const EdgeInsets.symmetric(horizontal: 3.0),
        activeShape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(25.0),
        ),
      ),
      onDone: () {
        Navigator.pushReplacementNamed(context, '/');
      },
    );
  }
}
