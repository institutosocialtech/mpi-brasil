import 'package:flutter/material.dart';
import '../models/drug.dart';

class MedicamentoInfo extends StatelessWidget {
  final Drug drug;
  MedicamentoInfo({Key key, this.drug}) : super(key: key);

  //
  // Title Font Style
  final TextStyle tileTitle = TextStyle(fontWeight: FontWeight.bold);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: ListView(
        children: <Widget>[
          drawTitleBar(drug),
          ListTile(
            title: Text("Classe Farmacológica", style: tileTitle),
            subtitle: Text(drug.drugTypesToString(), textAlign: TextAlign.justify),
          ),
          drawAvoidIndependently(drug),
          ListTile(
            title: Text("Condições a serem evitadas", style: tileTitle),
            subtitle: Text(drug.avoidSpecificallyConditions.toString(), textAlign: TextAlign.justify),
          ),
          ListTile(
            title: Text("Alternativas Terapeuticas", style: tileTitle),
            subtitle: Text(drug.alternatives.toString(), textAlign: TextAlign.justify),
          ),
          ListTile(
            title: Text("Orientações de Desprescrição", style: tileTitle),
            subtitle: Text(drug.desprescription.toString(), textAlign: TextAlign.justify),
          ),
          ListTile(
            title: Text("Monitorar", style: tileTitle),
            subtitle: Text(drug.monitoredParameters.toString(), textAlign: TextAlign.justify),
          ),
          ListTile(
            title: Text("Referências", style: tileTitle),
            subtitle: Text(drug.references.toString(), textAlign: TextAlign.justify),
          ),
        ],
      ),
    );
  }

  //
  // Drug Title Bar
  Widget drawTitleBar(Drug drug) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Text(drug.name, textScaleFactor: 2, style: tileTitle),
          Row(
            children: <Widget>[
              IconButton(icon: Icon(Icons.star), color: Colors.orange, iconSize: 24, onPressed: () {},),
              IconButton(icon: Icon(Icons.share), color: Colors.blueGrey, iconSize: 24, onPressed: () {},),
            ],
          ),
        ],
      ),
    );
  }


  //
  // MPI Reason and Exceptions
  Widget drawAvoidIndependently(Drug drug) {
    List<Widget> drawList = [];

    if (drug.avoidIndependently) {
      drawList.add(
        ListTile(
          title: Text("MPI Independente de Condição Clínica", style: tileTitle),
          subtitle: Text("Sim"),
        ),
      );

      if (drug.avoidIndependentlyReason.isNotEmpty) {
        drawList.add(
          ExpansionTile(
            title: Text("Racional MPI", style: tileTitle),
            children: <Widget>[
              Padding(
                padding: EdgeInsets.fromLTRB(20, 0, 40, 25),
                child: Text(drug.avoidIndependentlyReason, textAlign: TextAlign.justify),
              ),
            ],
          ),
        );
      }

      if (drug.avoidIndependentlyExceptions.isNotEmpty) {
        drawList.add(
          ExpansionTile(
            title: Text("Exceção MPI", style: tileTitle),
            children: <Widget>[
              Padding(
                padding: EdgeInsets.fromLTRB(20, 0, 40, 25),
                child: Text(drug.avoidIndependentlyExceptions, textAlign: TextAlign.justify),
              ),
            ],
          ),
        );
      }
    } else {
      drawList.add(
        ListTile(
          title: Text("MPI Independente de Condição Clínica", style: tileTitle),
          subtitle: Text("Não"),
        ),
      );
    }

    return Column(children: drawList);

  }

}