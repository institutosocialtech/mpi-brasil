import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/keyword.dart';
import '../providers/keywords.dart';
import '../screens/keyword_details.dart';

class KeywordsOverview extends StatelessWidget {
  final headerStyle = TextStyle(
    color: Colors.white,
    fontWeight: FontWeight.bold,
  );

  @override
  Widget build(BuildContext context) {
    final keywordsData = Provider.of<Keywords>(context);
    final keywords = keywordsData.keywords;

    return Scaffold(
      appBar: AppBar(
        title: Text('MPI Brasil'),
        titleSpacing: 0.0,
        elevation: 0,
      ),

      body: Column(
        children: <Widget>[
          // Header
          Container(
            height: 80,
            color: Colors.green,
            child: Row(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                  child: Text("Glossário".toUpperCase(), textScaleFactor: 1.5, style: headerStyle),
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
                  builder: (context) => KeywordDetails(keyword: keywords[index]),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
