import 'package:flutter/material.dart';
import '../models/glossario.dart';

class Glossario extends StatelessWidget {
  List<GlossarioItem> glossarioList = [];

  populateGlossarioList() {
    for (int item = 0; item<15; item++) {
      glossarioList.add(GlossarioItem(name: 'Acatisia ['+ item.toString() +']', description: 'Uma condição caracterizada por inquietação motora incontrolável.'));
    }
  }

  @override
  Widget build(BuildContext context) {
    if (glossarioList.isEmpty) {
      print("populating glossarioList");
      populateGlossarioList();
    }

    return Scaffold(
        body: ListView.builder(
          itemCount: glossarioList.length,
          itemBuilder: (BuildContext context, int index) {
            return ExpansionTile(
              title: Text(glossarioList[index].name),
              children: <Widget>[
                ListTile(title: Text(glossarioList[index].description)),
              ],
            );
          },
        ),
    );
  }
}