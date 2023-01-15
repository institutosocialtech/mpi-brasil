import 'package:flutter/material.dart';
import 'package:introduction_screen/introduction_screen.dart';
import 'package:mpibrasil/constants.dart';

class OnboardingScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var pageDecoration = PageDecoration(
      bodyTextStyle: TextStyle(
        color: kColorMPIGray,
        fontSize: 20,
        fontWeight: FontWeight.normal,
      ),
      titleTextStyle: TextStyle(
        color: kColorMPIGray,
        fontSize: 22,
        fontWeight: FontWeight.bold,
      ),
    );

    final pages = [
      // finalidade
      PageViewModel(
        decoration: pageDecoration,
        title: 'Qual o nosso objetivo?',
        body:
            'Auxiliar profissionais de saúde na tomada de decisão clínica e na realização da escolha do medicamento mais apropriado para cada doença específica e para cada paciente em particular.',
        image: Center(
            child: Image.asset('assets/undraw/doctors.png', height: 175)),
      ),

      // medicamentos
      PageViewModel(
        decoration: pageDecoration,
        title: 'Medicamentos Inapropriados',
        body:
            'Acesse as principais informações sobre MPI de acordo com a condição clinica do paciente, com orientações de desprescrição e alternativas terapêuticas mais seguras.',
        image: Center(
            child: Image.asset('assets/undraw/medical_care.png', height: 175)),
      ),

      PageViewModel(
        decoration: pageDecoration,
        title: 'E se o MPI for necessário?',
        body:
            'Se mesmo assim, o uso do medicamento inapropriado for necessário, obtenha informações de monitoramento para tornar a farmacoterapia mais segura!',
        image: Center(
            child: Image.asset('assets/undraw/medicine.png', height: 175)),
      ),

      // glossario
      PageViewModel(
        decoration: pageDecoration,
        title: 'Ficou com dúvida?',
        body: 'Consulte a FAQ no menu principal do aplicativo.',
        image: Center(
            child: Image.asset('assets/undraw/questions.png', height: 175)),
      ),
    ];

    return IntroductionScreen(
      pages: pages,
      next: Text(
        "Avançar",
        style: TextStyle(color: kColorMPIGreen, fontWeight: FontWeight.bold),
      ),
      done: Text(
        "Iniciar",
        style: TextStyle(color: kColorMPIGreen, fontWeight: FontWeight.bold),
      ),
      globalBackgroundColor: Colors.white,
      dotsDecorator: DotsDecorator(
        size: const Size.square(10.0),
        activeSize: const Size(30.0, 10.0),
        activeColor: kColorMPIGreen,
        color: kColorMPIGray.withOpacity(0.18),
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
