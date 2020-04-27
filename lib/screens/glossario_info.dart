import 'package:flutter/material.dart';
import '../models/keyword.dart';

class GlossarioInfo extends StatelessWidget {
  final Keyword keyword;
  GlossarioInfo({Key key, this.keyword}) : super(key: key);
  final TextStyle tileTitle = TextStyle(fontWeight: FontWeight.bold);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('MPI Brasil'),
        titleSpacing: 0.0,
        elevation: 0,
      ),
      body: ListView(
        children: <Widget>[
          drawTitleBar(keyword),
          SizedBox(height: 20),
          ListTile(
            title: Text("Definição", style: tileTitle),
            subtitle: Text(keyword.definition, textAlign: TextAlign.justify,),
          ),
          keyword.synonyms == null
            ? Container()
            : ListTile(
              title: Text("Sinônimos", style: tileTitle),
              subtitle: Text(keyword.synonymsListToString(), textAlign: TextAlign.justify,),
          ),
          ListTile(
            title: Text("Referências", style: tileTitle),
            subtitle: keyword.source == null
                ? Text("Indisponível")
                : Text(keyword.source),
          ),
        ],
      ),
    );
  }

//
  // Keyword Title Bar
  Widget drawTitleBar(Keyword keyword) {
    TextStyle headerStyle =
        TextStyle(color: Colors.white, fontWeight: FontWeight.bold);

    return Container(
      color: Colors.green,
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Flexible(
            child: Text(keyword.word.toUpperCase(),
                textScaleFactor: 1.5,
                textAlign: TextAlign.left,
                style: headerStyle),
          ),
        ],
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
