import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:mpibrasil/models/drug.dart';
import 'package:mpibrasil/widgets/alternativesCard.dart';
import 'package:mpibrasil/widgets/cardReferences.dart';
import 'package:mpibrasil/widgets/conditionCard.dart';
import 'package:mpibrasil/widgets/monitorCard.dart';
import 'package:mpibrasil/widgets/painCard.dart';
import '../widgets/floatingMenu.dart';

class MedicamentoInfo extends StatelessWidget {
  final Drug drug;
  MedicamentoInfo({Key key, this.drug}) : super(key: key);
  final medTitleStyle =
      TextStyle(fontWeight: FontWeight.bold, color: Colors.white);
  final headerStyle = TextStyle(fontWeight: FontWeight.bold);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("MPI Brasil"),
        titleSpacing: 0,
        elevation: 0,
      ),
      body: Column(
        children: <Widget>[
          drawTitleBar(drug, context),
          Expanded(
            child: ListView(children: <Widget>[
              ListTile(
                  title: Text("Classe Farmacológica", style: headerStyle),
                  subtitle: Text(drug.drugTypesToString(),
                      textAlign: TextAlign.justify)),
              drawConditionsTile(drug),
              drawAlternatives(drug),
              drawExpansionTile(
                  "Orientações de Desprescrição", drug.desprescription),
              drawDrugMonitor(drug),
              drawDrugReferences(drug),
            ]),
          ),
        ],
      ),
      floatingActionButton: FloatingMenu(drug: drug),
    );
  }

  //
  // Drug Title Bar
  Widget drawTitleBar(Drug drug, BuildContext context) {
    return Container(
      color: Colors.green,
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Text(drug.name.toUpperCase(),
              textScaleFactor: 1.5, style: medTitleStyle),
        ],
      ),
    );
  }

  //
  // MPI Conditions
  Widget drawConditionsTile(Drug drug) {
    List<Widget> conditionTiles = [];

    if (drug.avoid_conditions == null) return Container();

    for (DrugAvoidCondition item in drug.avoid_conditions) {
      if (item.criticalLevel == 1) {
        continue;
      }

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
  // MPI Alternatives
  Widget drawAlternatives(Drug drug) {
    List<Widget> alternativeTiles = [];

    if (drug.alternatives == null) return Container();

    drug.alternatives.sort( (a, b) => a.order.compareTo(b.order) );

    for (DrugAlternatives item in drug.alternatives) {
      if (item.alternative.toUpperCase() == "DOR") {
        alternativeTiles.add(PainCard());
      } else {
        alternativeTiles.add(
          Padding(
            padding: EdgeInsets.fromLTRB(10, 0, 10, 5),
            child: Card(elevation: 5, child: AlternativesCard(item)),
          ),
        );
      }
    }

    return ExpansionTile(
      title: Text("Alternativas Terapêuticas", style: headerStyle),
      children: <Widget>[
        Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: alternativeTiles,
        ),
      ],
    );
  }

  //
  // MPI Monitor
  Widget drawDrugMonitor(Drug drug) {
    List<Widget> monitorTiles = [];

    if (drug.monitored_parameters == null) return Container();

    for (DrugMonitor item in drug.monitored_parameters) {
      monitorTiles.add(
        Padding(
          padding: EdgeInsets.fromLTRB(10, 0, 10, 5),
          child: Card(elevation: 5, child: MonitorCard(item)),
        ),
      );
    }

    return ExpansionTile(
      title: Text("Monitorar", style: headerStyle),
      children: <Widget>[
        Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: monitorTiles,
        ),
      ],
    );
  }

  //
  // MPI References
  Widget drawDrugReferences(Drug drug) {
    List<Widget> referenceTiles = [];

    if (drug.references == null) return Container();

    for (DrugReference item in drug.references) {
      referenceTiles.add(
        Padding(
          padding: EdgeInsets.fromLTRB(10, 0, 10, 5),
          child: InkWell(
            child: Card(elevation: 5, child: ReferencesCard(item)),
            onTap: () => launch(item.url),
          ),
        ),
      );
    }

    return ExpansionTile(
      title: Text("Referências", style: headerStyle),
      children: <Widget>[
        Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: referenceTiles,
        ),
      ],
    );
  }

  //
  // Custom ExpansionTile
  Widget drawExpansionTile(String title, String content) {
    if (content == null) return Container();

    return ExpansionTile(
      title: Text(title, style: headerStyle),
      children: <Widget>[
        Padding(
          padding: EdgeInsets.fromLTRB(20, 0, 40, 25),
          child: Text(content, textAlign: TextAlign.justify),
        ),
      ],
    );
  }
}
