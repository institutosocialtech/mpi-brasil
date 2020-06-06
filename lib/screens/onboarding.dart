import 'package:flutter/material.dart';
import 'package:introduction_screen/introduction_screen.dart';

class OnboardingScreen extends StatelessWidget {
  final pages = [
    // sobre a app
    PageViewModel(
      title: 'O que somos?',
      body:
          'Um instrumento de busca rápida sobre medicamentos potencialmente inapropriados para idosos disponíveis no brasil.',
      image: Center(child: Image.asset('assets/undraw/mobile_app.png', height: 175)),
    ),

    // finalidade
    PageViewModel(
      title: 'Qual a nossa finalidade?',
      body:
          'Buscamos auxiliar profissionais de saúde na tomada de decisão clínica.',
      image: Center(child: Image.asset('assets/undraw/doctors.png', height: 175)),
    ),

    // medicamentos
    PageViewModel(
      title: 'Sobre os Medicamentos',
      body:
          'Saiba como utilizar os medicamentos de acordo com a condição clinica, as orientações de monitoramento, de desprescrição e alternativas terapêuticas apropriadas.',
      image: Center(child: Image.asset('assets/undraw/medical_care.png', height: 175)),
    ),

    // glossario
    PageViewModel(
      title: 'Ficou com dúvida?',
      body: 'Consulte o nosso glossário com mais informações.',
      image: Center(child: Image.asset('assets/undraw/questions.png', height: 175)),
    ),

    // fim
    PageViewModel(
      title: 'Pronto!',
      body: 'Você agora pode utilizar o nosso aplicativo.',
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
