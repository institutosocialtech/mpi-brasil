import 'package:flutter/material.dart';
import '../models/drugs.dart';
import '../models/drug.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'medicamento_info.dart';

class Medicamentos extends StatelessWidget {
  final medList = drugs;
  final TextStyle headerStyle = TextStyle(color: Colors.white, fontWeight: FontWeight.bold);
  final url = "https://mpibrasil.firebaseio.com/v2_0_0/pt/meds.json";



  //   // load
  // void loadDatabase() async {
  //   try{
  //     for (Drug drug in medList){
  //       final response = await http.post(url,
  //       body: json.encode(drug.toJson()  ));
  //       // print(json.decode(response.body)['name']);
  //     }

  //   }catch(error){
  //     throw(error);
  //   }
  // }

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
                    child: Text("Medicamentos", textScaleFactor: 2, style: headerStyle),
                  ),
                ],
              ),
            ),
          Expanded(
            child: Container(
              child: ListView.separated(
                itemCount: medList.length,
                separatorBuilder: (BuildContext context, int index) => Divider(),
                itemBuilder: (BuildContext context, int index) {
                  return ListTile(
                    contentPadding: EdgeInsets.symmetric(horizontal: 20),
                    title: Text(medList[index].name, style: TextStyle(fontWeight: FontWeight.bold),),
                    subtitle: Text(medList[index].drugTypesToString()),
                    trailing: IconButton(
                        icon: Icon(Icons.star_border),
                        color: Colors.orangeAccent,
                        onPressed: () {
                          print("setFavorite \"" + medList[index].name + "\"");
                        }),
                    onTap: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context) => MedicamentoInfo(drug: medList[index]),),);
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