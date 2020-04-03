import 'package:flutter/material.dart';
import '../models/drugs.dart';
import 'medicamento_info.dart';

class Medicamentos extends StatelessWidget {
  final medList = drugs;
  final TextStyle headerStyle = TextStyle(color: Colors.white, fontWeight: FontWeight.bold);

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