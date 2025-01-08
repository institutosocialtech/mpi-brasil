import 'package:flutter/material.dart';
import 'package:introduction_screen/introduction_screen.dart';
import 'package:mpibrasil/assets.dart';
import 'package:mpibrasil/constants.dart';
import 'package:mpibrasil/generated/l10n.dart';

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
        title: S.current.onboardingObjectivePageTitle,
        body: S.current.onboardingObjectivePageBody,
        image: Center(
          child: Image.asset(MpiAssets.imgUndrawDoctors, height: 175),
        ),
      ),

      // medicamentos
      PageViewModel(
        decoration: pageDecoration,
        title: S.current.onboardingMpiPageTitle,
        body: S.current.onboardingMpiPageBody,
        image: Center(
          child: Image.asset(MpiAssets.imgUndrawMedicalCare, height: 175),
        ),
      ),

      // mpi necessario
      PageViewModel(
        decoration: pageDecoration,
        title: S.current.onboardingMpiNeededPageTitle,
        body: S.current.onboardingMpiNeededPageBody,
        image: Center(
          child: Image.asset(MpiAssets.imgUndrawMedicine, height: 175),
        ),
      ),

      // glossario
      PageViewModel(
        decoration: pageDecoration,
        title: S.current.onboardingKeywordsPageTitle,
        body: S.current.onboardingKeywordsPageBody,
        image: Center(
          child: Image.asset(MpiAssets.imgUndrawQuestions, height: 175),
        ),
      ),
    ];

    return IntroductionScreen(
      pages: pages,
      next: Text(
        S.current.onboardingActionNext,
        style: TextStyle(color: kColorMPIGreen, fontWeight: FontWeight.bold),
      ),
      done: Text(
        S.current.onboardingActionDone,
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
      onDone: () => Navigator.pushReplacementNamed(context, '/'),
    );
  }
}
