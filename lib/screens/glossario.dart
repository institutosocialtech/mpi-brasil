import 'package:flutter/material.dart';
import 'package:mpibrasil/models/keyword.dart';
import '../models/keywords.dart';
import './glossario_info.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';


class Glossario extends StatelessWidget {
  final keywordList = keywords;
  final TextStyle headerStyle = TextStyle(color: Colors.white, fontWeight: FontWeight.bold);
  final url = "https://mpibrasil.firebaseio.com/v2_0_0/pt/keywords.json";

// void loadDatabase() async {
//     try{
//       for (Keyword keyword in keywordList){
//         final response = await http.post(url,
//         body: json.encode(keyword.toJson()  ));
//         // print(json.decode(response.body)['name']);
//       }

//     }catch(error){
//       throw(error);
//     }
//   }
//fetch
  // void fetchDatabase() async {
  //     try{
  //       final response = await http.get(url);
  //       print(json.decode(response.body));
  //     }catch(error){
  //       throw(error);
  //     }
  // }

  @override
  Widget build(BuildContext context) {
    // loadDatabase();
    // for (Keyword keyword in keywordList){
    //   print(keyword.printJson());
    // }

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
