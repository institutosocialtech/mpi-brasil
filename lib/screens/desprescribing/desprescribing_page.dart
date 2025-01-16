import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mpibrasil/assets.dart';
import 'package:mpibrasil/constants.dart';
import 'package:mpibrasil/generated/l10n.dart';
import 'package:mpibrasil/models/prompt.dart';
import 'package:mpibrasil/screens/desprescribing/message_page.dart';
import 'package:mpibrasil/screens/desprescribing/prompt_page.dart';
import 'package:mpibrasil/screens/desprescribing/result_page.dart';

class DesprescribingPage extends StatelessWidget {
  const DesprescribingPage({super.key});

  Future<List<Prompt>> fetchPrompts() async {
    final String response = await rootBundle.loadString(
      MpiAssets.despPromptsJson,
    );

    final data = json.decode(response);
    return (data['conditions'] as List).map((e) => Prompt.fromJson(e)).toList();
  }

  void showResult(Map<String, dynamic> answers, BuildContext context) {
    int score = answers['result_score'];
    switch (score) {
      // mantain score
      case 0:
        var pageRoute = MaterialPageRoute(
          builder: (context) => QuizResultPage(
            title: S.current.despResultMaintainTreatment,
            message: S.current.despResultMantainTreatMentContent,
            svgAsset: MpiAssets.svgUndrawMedicalCare,
          ),
        );
        Navigator.of(context).push(pageRoute);
        break;

      // desprescribing score
      case > 0:
        var pageRoute = MaterialPageRoute(
          builder: (context) => DespResultPage(),
        );
        Navigator.of(context).push(pageRoute);
        break;

      // todo: implement error page
      default:
        Navigator.of(context).popUntil((route) => route.isFirst);
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final Future<List<Prompt>> prompts = fetchPrompts();

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Container(
          padding: EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Padding(
                padding: const EdgeInsets.only(bottom: 25.0),
                child: Image.asset(
                  MpiAssets.imgUndrawMedicine,
                  height: size.height * 0.20,
                ),
              ),

              Padding(
                padding: const EdgeInsets.only(bottom: 25.0),
                child: Text(
                  S.current.despPageTitle,
                  textAlign: TextAlign.center,
                  style: Theme.of(context)
                      .textTheme
                      .headlineMedium!
                      .copyWith(fontWeight: FontWeight.bold),
                ),
              ),

              Expanded(
                //padding: const EdgeInsets.only(bottom: 25.0),
                child: Text(
                  S.current.despPageContent,
                  textAlign: TextAlign.justify,
                  style: Theme.of(context)
                      .textTheme
                      .bodyLarge!
                      .copyWith(fontWeight: FontWeight.bold),
                ),
              ),

              // begin prompts
              ElevatedButton(
                onPressed: () async {
                  final promptList = await prompts;
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => DespPromptPage(
                        onQuizFinished: (answers) =>
                            showResult(answers, context),
                        prompts: promptList,
                      ),
                    ),
                  );
                },
                child: Text(S.current.despButtonStart),
                style: ElevatedButton.styleFrom(
                  textStyle: TextStyle(fontWeight: FontWeight.bold),
                  backgroundColor: kColorMPIGreen,
                  foregroundColor: kColorMPIWhite,
                ),
              ),

              // back to app
              ElevatedButton(
                onPressed: () => Navigator.of(context).pop(),
                child: Text(S.current.back),
                style: ElevatedButton.styleFrom(
                  textStyle: TextStyle(fontWeight: FontWeight.bold),
                  backgroundColor: kColorMPIGray,
                  foregroundColor: kColorMPIWhite,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
