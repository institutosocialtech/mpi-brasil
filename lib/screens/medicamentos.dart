import 'package:flutter/material.dart';
import '../models/drugs.dart';
import 'medicamento_info.dart';

class Medicamentos extends StatelessWidget {
  final medList = drugs;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: <Widget>[
          Container(
              height: 80,
              color: Colors.green,
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                child: TextField(
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.all(10),
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(15)),
                    prefixIcon: Icon(Icons.search),
                    suffixIcon: Icon(Icons.mic),
                    fillColor: Colors.white,
                    filled: true,
                    hintText: "Pesquisar por Medicamento",
                  ),
                ),
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