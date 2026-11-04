import 'package:flutter/material.dart';
import 'package:mpibrasil/app_bar_component.dart';
import 'package:mpibrasil/assets.dart';
import 'package:mpibrasil/constants.dart';
import 'package:mpibrasil/generated/l10n.dart';
import 'package:mpibrasil/models/keyword.dart';

class KeywordDetails extends StatelessWidget {
  final Keyword keyword;
  KeywordDetails({Key? key, required this.keyword}) : super(key: key);
  final TextStyle tileTitle = TextStyle(fontWeight: FontWeight.bold);

  @override
  Widget build(BuildContext context) {
    final headerStyle = TextStyle(
      color: Colors.white,
      fontSize: 24,
      fontWeight: FontWeight.bold,
    );

    return Scaffold(
    
      appBar:  PreferredSize(
    preferredSize: const Size.fromHeight(136.0),
    child: AppBarSec(child:  Text(
              keyword.word.toUpperCase(),
              style: headerStyle,
              overflow: TextOverflow.fade,
            ),), 
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
        child: ListView(
          children: <Widget>[
            SizedBox(height: 20),
            ListTile(
              title: Text(S.current.keywordDetailsDefinitionTileTitle,
                  style: tileTitle),
              subtitle: Text(
                keyword.definition,
                textAlign: TextAlign.justify,
              ),
            ),
            keyword.synonyms == null
                ? Container()
                : ListTile(
                    title: Text(S.current.keywordDetailsSynonymTileTitle,
                        style: tileTitle),
                    subtitle: Text(
                      keyword.synonymsListToString(),
                      textAlign: TextAlign.justify,
                    ),
                  ),
            ListTile(
              title: Text(S.current.keywordDetailsReferencesTileTitle,
                  style: tileTitle),
              subtitle: keyword.source.isEmpty
                  ? Text(S.current.unavailable)
                  : Text(keyword.source),
            ),
          ],
        ),
      ),
    );
  }

  //
  // Custom ExpansionTile
  Widget drawTile(String title, String content) {
    return ExpansionTile(
      title: Text(title, style: tileTitle),
      children: <Widget>[
        Padding(
          padding: EdgeInsets.fromLTRB(20, 0, 40, 25),
          child: Text(content, textAlign: TextAlign.justify),
        ),
      ],
    );
  }
}
