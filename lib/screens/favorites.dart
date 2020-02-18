import 'package:flutter/material.dart';
import '../models/medicamento.dart';

class Favorites extends StatelessWidget {

  List<Medicamento> medList = [];

  populateMedList() {
    for (int item = 0; item<15; item++) {
      medList.add(Medicamento(name: 'Aceclofenaco ['+ item.toString() +']', description: 'Agente anti-inflamatório não hormonal (AINE)'));
    }
  }

  @override
  Widget build(BuildContext context) {
    if (medList.isEmpty) {
      print("populating medList");
      populateMedList();
    }

    return Scaffold(
        body: ListView.separated(
          itemCount: medList.length,
          separatorBuilder: (BuildContext context, int index) => Divider(),
          itemBuilder: (BuildContext context, int index) {
            return ListTile(
              contentPadding: EdgeInsets.symmetric(horizontal: 16),
              title: Row(children: <Widget>[
                Text(medList[index].name),
                IconButton(icon: Icon(Icons.star), color: Colors.orangeAccent, iconSize: 16, padding: EdgeInsets.all(0), onPressed: () {})
              ]),
              subtitle: Text(medList[index].description),
              trailing: IconButton(icon: Icon(Icons.keyboard_arrow_right), color: Colors.black26, onPressed: () {}),
            );
          },
        ),
    );
  }
}