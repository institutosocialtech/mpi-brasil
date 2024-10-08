import 'package:flutter/material.dart';
import 'package:mpibrasil/assets.dart';
import 'package:mpibrasil/constants.dart';
import 'package:mpibrasil/generated/l10n.dart';
import 'package:mpibrasil/models/prompt.dart';

class DespPromptPage extends StatelessWidget {
  final Prompt prompt;

  const DespPromptPage({
    super.key,
    required this.prompt,
  });

  @override
  Widget build(BuildContext context) {
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
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                  ],
                ),
              ),

              // register response buttons
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ElevatedButton(
                    onPressed: () => Navigator.of(context).pop(),
                    child: Text(S.current.no),
                    style: ElevatedButton.styleFrom(
                      textStyle: TextStyle(fontWeight: FontWeight.bold),
                      backgroundColor: kColorMPIGreen,
                      foregroundColor: kColorMPIWhite,
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () => Navigator.of(context).pop(),
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
