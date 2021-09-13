import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:markdown_widget/markdown_widget.dart';
import 'package:mpibrasil/models/med.dart';
import 'package:mpibrasil/widgets/pain_card.dart';
import 'package:mpibrasil/widgets/floating_menu.dart';

import '../constants.dart';

class MedDetails extends StatelessWidget {
  final Med med;
  MedDetails({Key key, this.med}) : super(key: key);

  final appBarHeaderStyle = TextStyle(
    color: Colors.white,
    fontSize: 24,
    fontWeight: FontWeight.bold,
  );

  final headerStyle = TextStyle(fontWeight: FontWeight.bold);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kColorMPIGreenOpaque,

      appBar: AppBar(
        backgroundColor: kColorMPIGreen,

        // page appbar
        flexibleSpace: Container(
          child: Image.asset(
            'assets/images/med_composition.png',
            color: Colors.white.withOpacity(0.15),
            colorBlendMode: BlendMode.multiply,
            fit: BoxFit.cover,
          ),
        ),

        // page title
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(80),
          child: Container(
            alignment: Alignment.centerLeft,
            padding: EdgeInsets.only(left: 20.0, bottom: 30),
            child: Text(med.name.toUpperCase(), style: appBarHeaderStyle),
          ),
        ),
      ),

      // page content
      body: Container(
        //padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
        decoration: BoxDecoration(
          color: kColorMPIWhite,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(15.0),
            topRight: Radius.circular(15.0),
          ),
        ),
        child: ListView(
          padding: EdgeInsets.symmetric(vertical: 10.0),
          children: <Widget>[
            ListTile(
              title: Text("Classe Farmacológica", style: headerStyle),
              subtitle: Text(
                med.medTypesToString(),
                textAlign: TextAlign.justify,
              ),
            ),
            drawConditionsTile(med),
            drawAlternatives(med),
            drawExpansionTile(
                "Orientações de Desprescrição", med.desprescription),
            drawMedMonitor(med),
            drawMedReferences(med),
            SizedBox(height: 100),
          ],
        ),
      ),
      floatingActionButton: FloatingMenu(med: med),
    );
  }

  //
  // MPI Conditions
  Widget drawConditionsTile(Med med) {
    List<Widget> conditionTiles = [];

    if (med.conditionsToAvoid == null) return Container();

    med.conditionsToAvoid
        .sort((a, b) => a.criticalLevel.compareTo(b.criticalLevel));
    for (MedAvoidCondition item in med.conditionsToAvoid) {
      List<Widget> conditions = [];
      conditions.add(Text(item.name,
          textAlign: TextAlign.left,
          style: TextStyle(fontWeight: FontWeight.bold)));
      conditions.add(SizedBox(height: 10));
      conditions.addAll(MarkdownGenerator(
              data: item.description,
              styleConfig: StyleConfig(
                  pConfig: PConfig(
                      selectable: false,
                      textConfig: TextConfig(textAlign: TextAlign.justify))))
          .widgets);
      conditions.add(SizedBox(height: 10));
      if (item.exception != null) {
        conditions.add(
            Text("Exceção", style: TextStyle(fontWeight: FontWeight.bold)));
        conditions.addAll(MarkdownGenerator(
                data: item.exception,
                styleConfig: StyleConfig(
                    pConfig: PConfig(
                        selectable: false,
                        textConfig: TextConfig(textAlign: TextAlign.justify))))
            .widgets);
      }

      conditionTiles.add(
        Padding(
          padding: const EdgeInsets.fromLTRB(10, 0, 10, 5),
          child: Card(
              elevation: 5,
              child: Padding(
                padding: EdgeInsets.all(20),
                child: Column(children: conditions),
              )),
        ),
      );
    }
    conditionTiles.add(SizedBox(height: 20));
    return ExpansionTile(
      title: Text("Quando evitar este MPI", style: headerStyle),
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
  Widget drawAlternatives(Med med) {
    List<Widget> alternativeTiles = [];

    if (med.alternatives == null) return Container();

    med.alternatives.sort((a, b) => a.order.compareTo(b.order));

    for (MedAlternatives item in med.alternatives) {
      if (item.alternative.toUpperCase() == "DOR") {
        alternativeTiles.add(PainCard());
      } else {
        alternativeTiles.add(
          Padding(
            padding: EdgeInsets.fromLTRB(10, 0, 10, 5),
            child: Card(
                elevation: 5,
                child: Padding(
                    padding: EdgeInsets.all(20),
                    child: Column(
                      children: [
                        Text(item.alternative,
                            textAlign: TextAlign.left,
                            style: TextStyle(fontWeight: FontWeight.bold))
                      ]..addAll(MarkdownGenerator(
                          data: item.description,
                          styleConfig: StyleConfig(
                              pConfig: PConfig(
                                selectable: false,
                                textConfig:
                                    TextConfig(textAlign: TextAlign.justify),
                              ),
                              olConfig: OlConfig(
                                indexWidget: (deep, index) {
                                  index++;
                                  return Container(
                                    margin: EdgeInsets.only(left: 5, right: 5),
                                    child: Text(
                                      index < 10 ? '  $index.' : '$index.',
                                    ),
                                  );
                                },
                              ))).widgets),
                    ))),
          ),
        );
      }
    }
    alternativeTiles.add(SizedBox(height: 20));
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
  Widget drawMedMonitor(Med med) {
    List<Widget> monitorTiles = [];

    if (med.parametersToMonitor == null) return Container();

    for (MedMonitor item in med.parametersToMonitor) {
      monitorTiles.add(Padding(
        padding: EdgeInsets.fromLTRB(10, 0, 10, 5),
        child: Card(
          elevation: 5,
          child: Padding(
            padding: EdgeInsets.all(20),
            child: Column(
              children: MarkdownGenerator(
                      data: item.description,
                      styleConfig: StyleConfig(
                          pConfig: PConfig(
                              selectable: false,
                              textConfig:
                                  TextConfig(textAlign: TextAlign.justify))))
                  .widgets,
            ),
          ),
        ),
      ));
    }
    monitorTiles.add(SizedBox(height: 20));
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
  Widget drawMedReferences(Med med) {
    List<Widget> referenceTiles = [];

    if (med.references == null) return Container();

    for (MedReference item in med.references) {
      referenceTiles.add(Padding(
        padding: EdgeInsets.fromLTRB(10, 0, 10, 5),
        child: InkWell(
          child: Card(
            elevation: 5,
            child: Padding(
                padding: EdgeInsets.all(20),
                child: Text(
                  item.title,
                  textAlign: TextAlign.left,
                  style: TextStyle(fontWeight: FontWeight.bold),
                )),
          ),
          onTap: () => launch(item.url),
        ),
      ));
    }
    referenceTiles.add(SizedBox(height: 20));
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

    return ExpansionTile(title: Text(title, style: headerStyle), children: [
      Padding(
        padding: const EdgeInsets.fromLTRB(10, 0, 10, 5),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Card(
              elevation: 5,
              child: Padding(
                padding: EdgeInsets.all(20),
                child: Column(
                  children: MarkdownGenerator(
                    data: content,
                    styleConfig: StyleConfig(
                        pConfig: PConfig(
                          selectable: false,
                          textConfig: TextConfig(textAlign: TextAlign.justify),
                        ),
                        olConfig: OlConfig(
                          indexWidget: (deep, index) {
                            index++;
                            return Container(
                              margin: EdgeInsets.only(left: 5, right: 5),
                              child: Text(
                                index < 10 ? '  $index.' : '$index.',
                              ),
                            );
                          },
                        )),
                  ).widgets,
                ),
              ),
            ),
            SizedBox(height: 20),
          ],
        ),
      )
    ]);
  }
}
