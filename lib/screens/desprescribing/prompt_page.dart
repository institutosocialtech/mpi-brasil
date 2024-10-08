import 'package:flutter/material.dart';
import 'package:mpibrasil/constants.dart';
import 'package:mpibrasil/generated/l10n.dart';
import 'package:mpibrasil/screens/desprescribing/result_page.dart';

class DespPromptPage extends StatelessWidget {
  const DespPromptPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kColorMPIGreenOpaque,
      body: SafeArea(
        child: Container(
          padding: EdgeInsets.all(20.0),
          child: Column(
            children: [
              // title
              Padding(
                padding: const EdgeInsets.only(bottom: 25.0),
                child: Text(
                  'Prompt Page Title',
                  style: Theme.of(context)
                      .textTheme
                      .headlineMedium!
                      .copyWith(fontWeight: FontWeight.bold),
                ),
              ),

              // question
              Text(S.current.desprescribingPageContent),

              // spacer
              Expanded(child: Container()),

              // register response buttons
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ElevatedButton(
                    onPressed: () => Navigator.of(context).pop(),
                    child: Text(S.current.no),
                    style: ElevatedButton.styleFrom(
                      textStyle: TextStyle(fontWeight: FontWeight.bold),
                      backgroundColor: kColorMPIWhite,
                      foregroundColor: kColorMPIOrange,
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () => Navigator.of(context).pop(),
                    child: Text(S.current.yes),
                    style: ElevatedButton.styleFrom(
                      textStyle: TextStyle(fontWeight: FontWeight.bold),
                      backgroundColor: kColorMPIWhite,
                      foregroundColor: kColorMPIOrange,
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
