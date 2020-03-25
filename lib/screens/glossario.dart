import 'package:flutter/material.dart';
import '../models/keywords.dart';
import 'package:auto_size_text/auto_size_text.dart';
import './glossario_info.dart';

class Glossario extends StatelessWidget {
  final verbetes = keywords;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          Container(
            height: 540,
            child: ListView.separated(
              itemCount: verbetes.length,
              separatorBuilder: (BuildContext context, int index) => Divider(),
              itemBuilder: (BuildContext context, int index) {
                return ListTile(
//                  dense: true,
//                  contentPadding: EdgeInsets.symmetric(horizontal: 16),

                    title: Row(children: <Widget>[
                      Flexible(
                        child: AutoSizeText(
                          verbetes[index].word,
                          textAlign: TextAlign.justify,
                          maxLines: 2,
                          style:TextStyle(fontWeight: FontWeight.bold)
                        ),
                      ),
//                    IconButton(
//                        icon: Icon(Icons.star_border),
//                        color: Colors.orangeAccent,
//                        iconSize: 16,
//                        padding: EdgeInsets.all(0),
//                        onPressed: () {})
                    ]),
                    subtitle: verbetes[index].synonyms.isNotEmpty
                        ? (verbetes[index].synonyms[0].toString().isNotEmpty
                            ? AutoSizeText(
                                verbetes[index].synonyms[0].toString(),
                                textAlign: TextAlign.justify)
                            : Text(""))
                        : Text(""),
//                    trailing: IconButton(
//                      icon: Icon(Icons.keyboard_arrow_right),
//                      color: Colors.black26,
//                      onPressed: () {null;},
//                    ),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => GlossarioInfo(verbete:verbetes[index]),
                        ),
                      );
                    });
              },
            ),
          ),
        ],
      ),
    );
  }
}
