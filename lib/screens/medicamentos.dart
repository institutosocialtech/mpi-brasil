import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/drug.dart';
import '../providers/drugs.dart';
import '../screens/medicamento_info.dart';

class Medicamentos extends StatelessWidget {
  final headerStyle = TextStyle(
    color: Colors.white,
    fontWeight: FontWeight.bold,
  );

  @override
  Widget build(BuildContext context) {
    final drugsData = Provider.of<Drugs>(context);
    final drugs = drugsData.drugs;

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
                  child: Text("Medicamentos".toUpperCase(),
                      textScaleFactor: 1.5, style: headerStyle),
                ),
              ],
            ),
          ),
          Expanded(child: DrugList(drugs: drugs)),
        ],
      ),
    );
  }
}

class DrugList extends StatelessWidget {
  const DrugList({Key key, @required this.drugs}) : super(key: key);
  final List<Drug> drugs;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: ListView.separated(
        itemCount: drugs.length,
        separatorBuilder: (BuildContext context, int index) => Divider(),
        itemBuilder: (BuildContext context, int index) {
          return ListTile(
            contentPadding: EdgeInsets.symmetric(horizontal: 20),
            title: Text(
              drugs[index].name,
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            subtitle: Text(drugs[index].drugTypesToString()),
            trailing: IconButton(
                icon: Icon(Icons.star_border),
                color: Colors.orangeAccent,
                onPressed: () {
                  print("setFavorite \"" + drugs[index].name + "\"");
                }),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => MedicamentoInfo(drug: drugs[index]),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
