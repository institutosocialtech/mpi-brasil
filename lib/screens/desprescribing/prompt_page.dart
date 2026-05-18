import 'package:flutter/material.dart';
import 'package:mpibrasil/assets.dart';
import 'package:mpibrasil/constants.dart';
import 'package:mpibrasil/generated/l10n.dart';
import 'package:mpibrasil/models/prompt.dart';

class DespPromptPage extends StatefulWidget {
  final List<Prompt> prompts;
  final void Function(Map<String, dynamic>) onQuizFinished;

  const DespPromptPage({
    super.key,
    required this.onQuizFinished,
    required this.prompts,
  });

  @override
  State<DespPromptPage> createState() => _DespPromptPageState();
}

class _DespPromptPageState extends State<DespPromptPage> {
  int _questionIndex = 0;
  Map<String, dynamic> _quiz = {
    'answers': <String, bool>{},
    'result_score': -1,
  };

  void setAnswer(String promptId, bool answer) {
    setState(() {
      (_quiz['answers'] as Map<String, bool>)[promptId] = answer;
      _questionIndex++;
    });
  }

  int scoreCount() {
    return (_quiz['answers'] as Map<String, bool>)
        .values
        .where((answer) => answer)
        .length;
  }

  Future<void> showResults() async {
    setState(() => _quiz["result_score"] = scoreCount());
    await Future.delayed(Duration(milliseconds: 500));
    widget.onQuizFinished(_quiz);
  }

  @override
  Widget build(BuildContext context) {
    if (_questionIndex >= widget.prompts.length) {
      return Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
          child: Container(
            padding: EdgeInsets.all(20.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // image header
                Image.asset(
                  MpiAssets.imgUndrawMedicine,
                  height: MediaQuery.of(context).size.height * 0.30,
                ),

                // show result prompt
                Padding(
                  padding: const EdgeInsets.only(bottom: 25.0),
                  child: Text(
                    S.current.despShowResultsTitle,
                    textAlign: TextAlign.center,
                    style: Theme.of(context)
                        .textTheme
                        .headlineMedium!
                        .copyWith(fontWeight: FontWeight.bold),
                  ),
                ),

                // show results button
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ElevatedButton(
                      onPressed: () => showResults(),
                      child: Text(S.current.despShowResultsButtonLabel),
                      style: ElevatedButton.styleFrom(
                        textStyle: TextStyle(fontWeight: FontWeight.bold),
                        backgroundColor: kColorMPIGreen,
                        foregroundColor: kColorMPIWhite,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      );
    }

    var prompt = widget.prompts[_questionIndex];

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Container(
          padding: EdgeInsets.all(20.0),
          child: Column(
            children: [
              // image header
              Image.asset(
                MpiAssets.imgUndrawMedicine,
                height: MediaQuery.of(context).size.height * 0.20,
              ),

              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // title
                    Padding(
                      padding: const EdgeInsets.only(bottom: 25.0),
                      child: Text(
                        prompt.title,
                        textAlign: TextAlign.center,
                        style: Theme.of(context)
                            .textTheme
                            .headlineMedium!
                            .copyWith(fontWeight: FontWeight.bold),
                      ),
                    ),

                    // question
                    Text(
                      prompt.description,
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.bodyLarge,
                    ),
                  ],
                ),
              ),

              // register response buttons
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ElevatedButton(
                    onPressed: () => setAnswer(prompt.id, false),
                    child: Text(S.current.no),
                    style: ElevatedButton.styleFrom(
                      textStyle: TextStyle(fontWeight: FontWeight.bold),
                      backgroundColor: kColorMPIGreen,
                      foregroundColor: kColorMPIWhite,
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () => setAnswer(prompt.id, true),
                    child: Text(S.current.yes),
                    style: ElevatedButton.styleFrom(
                      textStyle: TextStyle(fontWeight: FontWeight.bold),
                      backgroundColor: kColorMPIGreen,
                      foregroundColor: kColorMPIWhite,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
