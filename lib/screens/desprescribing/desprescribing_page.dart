import 'package:flutter/material.dart';
import 'package:mpibrasil/constants.dart';
import 'package:mpibrasil/generated/l10n.dart';
import 'package:mpibrasil/screens/desprescribing/prompt_page.dart';
import 'package:mpibrasil/screens/desprescribing/result_page.dart';

class DesprescribingPage extends StatelessWidget {
  const DesprescribingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(S.current.desprescribingPageTitle),
      ),
      body: Padding(
        padding: EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              S.current.desprescribingPageContent,
              textAlign: TextAlign.justify,
            ),
            Expanded(child: Container()),

            // begin prompts
            ElevatedButton(
              onPressed: () => Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => DespPromptPage(),
                ),
              ),
              child: Text(S.current.desprescribingStart),
              style: ElevatedButton.styleFrom(
                backgroundColor: kColorMPIGreen,
                foregroundColor: kColorMPIWhite,
              ),
            ),

            // todo: remove before feature launch
            ElevatedButton(
              onPressed: () => Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => DespResultPage(
                    bgColor: kColorMPIGreenOpaque,
                    resultTitle: S.current.considerNotDeprescribingTitle,
                    resultContentList: S.current.considerNotDeprescribingList,
                  ),
                ),
              ),
              child: Text(S.current.considerNotDeprescribingTitle),
              style: ElevatedButton.styleFrom(
                backgroundColor: kColorMPIGreen,
                foregroundColor: kColorMPIWhite,
              ),
            ),

            // todo: remove before feature launch
            ElevatedButton(
              onPressed: () => Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => DespResultPage(
                    bgColor: kColorMPIOrange,
                    resultTitle: S.current.considerDeprescribingTitle,
                    resultContentList: S.current.considerDeprescribingList,
                  ),
                ),
              ),
              child: Text(S.current.considerDeprescribingTitle),
              style: ElevatedButton.styleFrom(
                backgroundColor: kColorMPIGreen,
                foregroundColor: kColorMPIWhite,
              ),
            ),

            // todo: remove before feature launch
            ElevatedButton(
              onPressed: () => Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => DespResultPage(
                    bgColor: kColorMPIGreenOpaque,
                    resultTitle: S.current.howToDeprescribeTitle,
                    resultContentList: S.current.howToDeprescribeList,
                  ),
                ),
              ),
              child: Text(S.current.howToDeprescribeTitle),
              style: ElevatedButton.styleFrom(
                backgroundColor: kColorMPIGreen,
                foregroundColor: kColorMPIWhite,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
