import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../models/keyword.dart';
import '../screens/glossario_info.dart';


class Glossario extends StatelessWidget {
  final url = "https://mpibrasil.firebaseio.com/v2_0_0/pt/keywords.json";
  final headerStyle = TextStyle(color: Colors.white, fontWeight: FontWeight.bold);

  //fetch
  Future<List<Keyword>> fetchKeywords() async {
    var data = [];
    print("loading keyword db...");
    final response = await http.get(url, headers: {"Accept": "application/json"});

    if (response.statusCode == 200) {
        print("keyword db loaded, filling list!");
        Map<String,dynamic> map = json.decode(response.body);
        map.forEach((key, value) => data.add(Keyword.fromJson(value)));
    } else {
      print("error loading keywords: " + response.statusCode.toString());
    }
    print("done loading keywords.");
    return data;
  }

  @override
  Widget build(BuildContext context) {
    var keywordList = [];

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
                      Navigator.push(context, MaterialPageRoute(builder: (context) => GlossarioInfo(keyword: keywordList[index]),),);
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
