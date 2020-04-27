import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/keyword.dart';
import '../providers/keywords.dart';
import '../screens/glossario_info.dart';

class Glossario extends StatelessWidget {
  final headerStyle = TextStyle(
    color: Colors.white,
    fontWeight: FontWeight.bold,
  );

  @override
  Widget build(BuildContext context) {
    final keywordsData = Provider.of<Keywords>(context);
    final keywords = keywordsData.keywords;

    return Scaffold(
      body: Column(
        children: <Widget>[
          // Header
          Container(
            height: 80,
            color: Colors.green,
            child: Row(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Text("Glossário", textScaleFactor: 2, style: headerStyle),
                ),
              ],
            ),
          ),
          // Content
          Expanded(child: KeywordList(keywords: keywords)),
        ],
      ),
    );
  }
}

class KeywordList extends StatelessWidget {
  const KeywordList({Key key, @required this.keywords}) : super(key: key);

  final List<Keyword> keywords;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: ListView.separated(
        itemCount: keywords.length,
        separatorBuilder: (BuildContext context, int index) => Divider(),
        itemBuilder: (BuildContext context, int index) {
          return ListTile(
            contentPadding: EdgeInsets.symmetric(horizontal: 20),
            title: Text(
              keywords[index].word,
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            subtitle: keywords[index].synonyms == null ? null : Text(keywords[index].synonymsListToString()),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => GlossarioInfo(keyword: keywords[index]),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
