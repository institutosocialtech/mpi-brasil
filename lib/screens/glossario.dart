import 'package:flutter/material.dart';
import '../models/keywords.dart';
import './glossario_info.dart';

class Glossario extends StatelessWidget {
  final keywordList = keywords;
  TextStyle headerStyle = TextStyle(color: Colors.white, fontWeight: FontWeight.bold);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: <Widget>[
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
          Expanded(
            child: Container(
              child: ListView.separated(
                itemCount: keywordList.length,
                separatorBuilder: (BuildContext context, int index) => Divider(),
                itemBuilder: (BuildContext context, int index) {
                  return ListTile(
                    contentPadding: EdgeInsets.symmetric(horizontal: 20),
                    title: Text(keywordList[index].word, style: TextStyle(fontWeight: FontWeight.bold),),
                    subtitle: Text( keywordList[index].synonymsListToString() ),
                    onTap: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context) => GlossarioInfo(verbete: keywordList[index]),),);
                    },
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
