import 'package:flutter/material.dart';
import '../models/keyword.dart';
import 'package:auto_size_text/auto_size_text.dart';

class GlossarioInfo extends StatelessWidget {
  final Keyword verbete;

  GlossarioInfo({Key key, this.verbete}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: getListView(),
    );
  }

  Widget getListView() {
    var listView = ListView(
      children: <Widget>[
        Container(
          child: ListTile(
            title: Row(
              children: <Widget>[
                Flexible(
                  child: AutoSizeText(
                    verbete.word.toString(),
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.justify,
//                    textScaleFactor: 1.4,
                  ),
                ),
              ],
            ),
            subtitle: Row(
              children: <Widget>[
                Flexible(
                  child: verbete.synonyms.isNotEmpty
                      ? (verbete.synonyms[0].toString().isNotEmpty
                          ? Text(
                              verbete.synonyms[0].toString(),
                              style: TextStyle(fontStyle: FontStyle.italic),
                              textAlign: TextAlign.justify,
//                              style: TextStyle(fontSize: 12),
                            )
                          : Text(""))
                      : Text(""),
                )
              ],
            ),
          ),
          color: Color.fromRGBO(254, 254, 252, 1),
          padding: EdgeInsets.all(10),
        ),
//        getBar(),
        ListTile(
          title: AutoSizeText(
            "Definition",
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          subtitle: Row(
            children: <Widget>[
              Flexible(
                child: AutoSizeText(
                  verbete.definition,
                  textAlign: TextAlign.justify,
                ),
              )
            ],
          ),
        ),
        ListTile(
          title: AutoSizeText(
            "Source:",
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          subtitle: Row(
            children: <Widget>[
              Flexible(
                  child: AutoSizeText(
                verbete.source,
                style: TextStyle(fontStyle: FontStyle.italic),
                textAlign: TextAlign.justify,
              ))
            ],
          ),
        ),
      ],
    );

    return listView;
  }
}
//
//Widget getBar() {
//  var bar = Container(
//    child: Row(
//      children: const <Widget>[
//        Padding(
//          padding: EdgeInsets.all(10.0),
//          child: IconButton(
//              icon: Icon(Icons.star),
//              color: Colors.amberAccent,
//              iconSize: 20,
//              onPressed: null),
//        ),
//        Padding(
//          padding: EdgeInsets.all(10.0),
//          child: IconButton(
//              icon: Icon(Icons.share), iconSize: 20, onPressed: null),
//        ),
//        Padding(
//          padding: EdgeInsets.all(10.0),
//          child: IconButton(
//              icon: Icon(Icons.info_outline), iconSize: 20, onPressed: null),
//        ),
//        Padding(
//          padding: EdgeInsets.all(10.0),
//          child: IconButton(
//              icon: Icon(Icons.format_size), iconSize: 20, onPressed: null),
//        ),
//      ],
//    ),
//    color: Color.fromRGBO(248, 249, 251, 1),
//    padding: EdgeInsets.all(10),
//  );
//
//  return bar;
//}
