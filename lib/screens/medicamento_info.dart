//import 'package:share/share.dart';
import 'package:flutter/material.dart';
import 'package:mpi_brasil/widgets/conditionCard.dart';
import '../models/drug.dart';

class MedicamentoInfo extends StatelessWidget {
  final Drug drug;
  MedicamentoInfo({Key key, this.drug}) : super(key: key);
  final medTitleStyle = TextStyle(fontWeight: FontWeight.bold, color: Colors.white);
  final headerStyle = TextStyle(fontWeight: FontWeight.bold);

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
            title: Text("Classe Farmacológica", style: headerStyle),
            subtitle:
                Text(drug.drugTypesToString(), textAlign: TextAlign.justify),
          ),
          drawConditionsTile(drug),
          drawExpansionTile(
              "Alternativas Terapeuticas", drug.alternatives.toString()),
          drawExpansionTile(
              "Orientações de Desprescrição", drug.desprescription.toString()),
          drawExpansionTile("Monitorar", drug.monitoredParameters.toString()),
          drawExpansionTile("Referências", drug.references.toString()),
        ],
      ),
    );
  }

  //
  // Drug Title Bar
  Widget drawTitleBar(Drug drug) {
    return Container(
      color: Colors.green,
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Text(drug.name, textScaleFactor: 2, style: medTitleStyle),
          Row(
            children: <Widget>[
              IconButton(
                  icon: Icon(Icons.star),
                  color: Colors.white,
                  iconSize: 24,
                  onPressed: () {}),
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
  Widget drawConditionsTile(Drug drug) {
    List<Widget> conditionTiles = [];
    
    for (DrugAvoidCondition item in drug.avoidConditions) {
      conditionTiles.add(
        Padding(
          padding: const EdgeInsets.fromLTRB(10, 0, 10, 5),
          child: Card(
            elevation: 5,
            child: ConditionCard(item),
          ),
        ),
      );
    }

    return ExpansionTile(
      title: Text("Condições a Serem Evitadas", style: headerStyle),
      children: <Widget>[
        Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: conditionTiles,
        ),
      ],
    );
  }

  //
  // Custom ExpansionTile
  Widget drawExpansionTile(String title, String content) {
    return ExpansionTile(
      title: Text(title, style: headerStyle),
          padding: EdgeInsets.fromLTRB(20, 0, 40, 25),
          child: Text(content, textAlign: TextAlign.justify),
        ),
      ],
    );
  }
}
