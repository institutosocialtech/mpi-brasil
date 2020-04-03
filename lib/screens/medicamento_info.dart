import 'package:share/share.dart';
import 'package:flutter/material.dart';
import '../models/drug.dart';

class MedicamentoInfo extends StatelessWidget {
  final Drug drug;
  MedicamentoInfo({Key key, this.drug}) : super(key: key);

  //
  // Title Font Style
  final TextStyle tileTitle =
      TextStyle(fontWeight: FontWeight.bold, fontFamily: "Arial");

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("MPI Brasil"),
        titleSpacing: 0,
        elevation: 0,
      ),
      body: ListView(
        children: <Widget>[
          drawTitleBar(drug),
          ListTile(
            title: Text("Classe Farmacológica", style: tileTitle),
            subtitle:
                Text(drug.drugTypesToString(), textAlign: TextAlign.justify),
          ),
          drawAvoidIndependently(drug),
          drawTile("Condições a serem evitadas",
              drug.avoidSpecificallyConditions.toString()),
          drawTile("Alternativas Terapeuticas", drug.alternatives.toString()),
          drawTile(
              "Orientações de Desprescrição", drug.desprescription.toString()),
          drawTile("Monitorar", drug.monitoredParameters.toString()),
          drawTile("Referências", drug.references.toString()),
        ],
      ),
    );
  }

  //
  // Drug Title Bar
  Widget drawTitleBar(Drug drug) {
    TextStyle headerStyle = TextStyle(color: Colors.white, fontWeight: FontWeight.bold);

    return Container(
      color: Colors.green,
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Text(drug.name, textScaleFactor: 2, style: headerStyle),
          Row(
            children: <Widget>[
              IconButton(
                icon: Icon(Icons.star),
                color: Colors.white,
                iconSize: 24,
                onPressed: () {},
              ),
              IconButton(
                icon: Icon(Icons.share),
                color: Colors.white,
                iconSize: 24,
                onPressed: () {
                    Share.share("${drug.name}\n\nClasse Farmacológica:\n${drug.drugTypesToString()}\n\nÉ um medicamento potencialmente inapropriado porque:\n${drug.avoidIndependentlyReason}..Saiba mais acessando MPI Brasil link");
                },
              ),
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
                child: Text(drug.avoidIndependentlyReason,
                    textAlign: TextAlign.justify),
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
                child: Text(drug.avoidIndependentlyExceptions,
                    textAlign: TextAlign.justify),
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

  //
  // Custom ExpansionTile
  Widget drawTile(String title, String content) {
    return ExpansionTile(
      title: Text(title, style: tileTitle),
      children: <Widget>[
        Padding(
          padding: EdgeInsets.fromLTRB(20, 0, 40, 25),
          child: Text(content, textAlign: TextAlign.justify),
        ),
      ],
    );
  }
}
