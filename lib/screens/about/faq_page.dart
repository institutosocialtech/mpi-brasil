import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:markdown_widget/markdown_widget.dart';
import 'package:mpibrasil/assets.dart';
import 'package:mpibrasil/constants.dart';
import 'package:mpibrasil/generated/l10n.dart';
import 'package:mpibrasil/models/faq.dart';

class FAQPage extends StatelessWidget {
  final headerStyle = TextStyle(
    color: Colors.white,
    fontSize: 24,
    fontWeight: FontWeight.bold,
  );

  Future<List<FAQ>> loadFAQData(BuildContext context) async {
    final String response = await rootBundle.loadString('assets/docs/faq.json');
    final Map<String, dynamic> data = json.decode(response);
    final locale = Localizations.localeOf(context).languageCode;
    return (data[locale] as List).map((e) => FAQ.fromJson(e)).toList();
  }

  // TODO: MarkdownGenerator: fix textStyle(KcolorTextLightGray), textConfig(TextAlign.justify), linkStyle (KColorMPIGreen, FontWeight.bold)
  Widget FAQList(List<FAQ> faqList) {
    return ListView.builder(
      itemCount: faqList.length,
      itemBuilder: (context, index) {
        final faq = faqList[index];
        return ExpansionTile(
          title: Text(
            faq.question,
            textAlign: TextAlign.left,
            style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
          ),
          children: <Widget>[
            Padding(
              padding: EdgeInsets.fromLTRB(20, 10, 20, 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: MarkdownGenerator().buildWidgets(faq.answer),
              ),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kColorMPIGreenOpaque,
      appBar: AppBar(
        backgroundColor: kColorMPIGreen,

        // page appbar
        flexibleSpace: Container(
          child: Image.asset(
            MpiAssets.imgMedComposition,
            color: Colors.white.withOpacity(0.15),
            colorBlendMode: BlendMode.multiply,
            fit: BoxFit.cover,
          ),
        ),

        // page title
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(80),
          child: Container(
            alignment: Alignment.centerLeft,
            padding: EdgeInsets.only(left: 20.0, bottom: 40),
            child: Text(S.current.faqPageTitle, style: headerStyle),
          ),
        ),
      ),

      // page content
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
        decoration: BoxDecoration(
          color: kColorMPIWhite,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(15.0),
            topRight: Radius.circular(15.0),
          ),
        ),
        child: Column(
          children: [
            Expanded(
              child: FutureBuilder<List<FAQ>>(
                future: loadFAQData(context),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(child: CircularProgressIndicator());
                  } else if (snapshot.hasError) {
                    return Center(child: Text('${snapshot.error}'));
                  } else {
                    final faqList = snapshot.data!;
                    return FAQList(faqList);
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
