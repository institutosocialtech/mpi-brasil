import 'package:flutter/material.dart';
import '../models/drug.dart';

class MedicamentoInfo extends StatelessWidget {
  final Drug drug;
  MedicamentoInfo({Key key, this.drug}) : super(key: key);

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
            title: Text(
              drug.name,
              textScaleFactor: 1.5,
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
          color: Color.fromRGBO(254, 254, 252, 1),
          padding: EdgeInsets.all(10),
        ),
        getBar(),
        ListTile(
          title: Text(
            "Classe Farmacológica",
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          subtitle: Text(drug.type.toString()),
        ),
        ListTile(
          title: Text(
            "MPI Independente de Condição Clínica",
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          subtitle: Text(drug.avoidIndependently ? "SIM" : "NÃO"),
        ),
        ListTile(
          title: Text(
            "Racional",
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          subtitle: Text(drug.avoidIndependentlyReason),
        ),
      ],
    );

    return listView;
  }
}

Widget getBar() {
  return Container(
    //Scolor: Color.fromRGBO(248, 249, 251, 1),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Padding(
          padding: EdgeInsets.symmetric(horizontal:15, vertical: 0),
          child: IconButton(
              icon: Icon(Icons.star),
              color: Colors.orangeAccent,
              iconSize: 20,
              onPressed: null),
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal:15, vertical: 0),
          child: IconButton(
              icon: Icon(Icons.share),
              iconSize: 20,
              onPressed: null),
        ),
      ],
    ),
  );
}
