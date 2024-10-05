import 'package:flutter/material.dart';
import 'package:markdown_widget/markdown_widget.dart';
import 'package:url_launcher/url_launcher.dart';

import 'package:mpibrasil/assets.dart';
import 'package:mpibrasil/constants.dart';
import 'package:mpibrasil/extensions.dart';
import 'package:mpibrasil/models/med.dart';
import 'package:mpibrasil/widgets/pain_card.dart';
import 'package:mpibrasil/widgets/floating_menu.dart';

class MedDetails extends StatelessWidget {
  final Med med;
  MedDetails({Key? key, required this.med}) : super(key: key);

  final appBarHeaderStyle = TextStyle(
    // TODO: use constants for colors
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
            MpiAssets.imgMedComposition,
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
              title: Text(
                S.current.medDetailsMedTypeTileTitle,
                style: headerStyle,
              ),
              subtitle: Text(
                med.medTypesToString(),
                textAlign: TextAlign.justify,
              ),
            ),
            drawConditionsTile(med, context),
            drawAlternatives(med, context),
            if (med.hasDesprescribing())
              drawExpansionTile(
                S.current.medDetailsDeprescribingTileTitle,
                med.desprescription!,
              ),
            drawMedMonitor(med, context),
            drawMedReferences(med, context),
            SizedBox(height: 100),
          ],
        ),
      ),
      floatingActionButton: FloatingMenu(med: med),
    );
  }

  //
  // MPI Conditions
  Widget drawConditionsTile(Med med, BuildContext context) {
    if (!med.hasConditionsToAvoid()) return Container();

    // sort avoid conditions by critical level
    med.conditionsToAvoid!
        .sort((a, b) => a.criticalLevel!.compareTo(b.criticalLevel!));

    // TODO: MarkdownGenerator: fix textConfig(TextAlign.justify)
    List<Widget> conditionTiles = [];
    for (MedAvoidCondition item in med.conditionsToAvoid!) {
      List<Widget> conditions = [
        // title
        Text(
          item.name!,
          textAlign: TextAlign.left,
          style: TextStyle(fontWeight: FontWeight.bold),
        ),

        // description
        SizedBox(height: 10),
        ...MarkdownGenerator().buildWidgets(item.description!),

        // footer
        SizedBox(height: 10)
      ];

      // draw avoid exceptions
      if (item.hasException()) {
        conditions.addAll(
          [
            // exception header
            Text(
              S.current.medDetailsAvoidConditionExceptionLabel,
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            // exception description
            ...MarkdownGenerator().buildWidgets(item.exception!),
            // footer
            SizedBox(height: 10),
          ],
        );
      }

      conditionTiles.add(
        Padding(
          padding: const EdgeInsets.fromLTRB(10, 0, 10, 5),
          child: Card(
            elevation: 5,
            child: Padding(
              padding: EdgeInsets.all(20),
              child: Column(children: conditions),
            ),
          ),
        ),
      );
    }

    conditionTiles.add(SizedBox(height: 20));

    return ExpansionTile(
      title: Text(
        S.current.medDetailsAvoidConditionTileTitle,
        style: headerStyle,
      ),
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
  Widget drawAlternatives(Med med, BuildContext context) {
    if (!med.hasAlternativeTherapy()) return Container();

    // sort alternatives by order
    med.alternatives!.sort((a, b) => a.order.compareTo(b.order));

    // TODO: remove hardcoded parsing
    // TODO: MarkdownWidget: fix textConfig(TextAlign.justify), olConfig(index container)
    List<Widget> alternativeTiles = [];
    for (MedAlternatives item in med.alternatives!) {
      if (item.alternative.toUpperCase() == "DOR") {
        alternativeTiles.add(PainCard());
        continue;
      }

      alternativeTiles.add(
        Padding(
          padding: EdgeInsets.fromLTRB(10, 0, 10, 5),
          child: Card(
            elevation: 5,
            child: Padding(
              padding: EdgeInsets.all(20),
              child: Column(
                children: [
                  Text(
                    item.alternative,
                    textAlign: TextAlign.left,
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  ...MarkdownGenerator().buildWidgets(item.description)
                ],
              ),
            ),
          ),
        ),
      );
    }

    alternativeTiles.add(SizedBox(height: 20));
    return ExpansionTile(
      title: Text(
        S.current.medDetailsAlternativeTherapyTileTitle,
        style: headerStyle,
      ),
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
  Widget drawMedMonitor(Med med, BuildContext context) {
    if (!med.hasMonitoredParameters()) return Container();

    // TODO: MarkdownGenerator: fix textConfig(TextAlign.justify)
    List<Widget> monitorTiles = [];
    for (MedMonitor item in med.parametersToMonitor!) {
      monitorTiles.add(
        Padding(
          padding: EdgeInsets.fromLTRB(10, 0, 10, 5),
          child: Card(
            elevation: 5,
            child: Padding(
              padding: EdgeInsets.all(20),
              child: Column(
                children: MarkdownGenerator().buildWidgets(item.description!),
              ),
            ),
          ),
        ),
      );
    }

    monitorTiles.add(SizedBox(height: 20));
    return ExpansionTile(
      title: Text(
        S.current.medDetailsMonitoredParametersTileTitle,
        style: headerStyle,
      ),
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
  Widget drawMedReferences(Med med, BuildContext context) {
    if (!med.hasReferences()) return Container();

    List<Widget> referenceTiles = [];
    for (MedReference item in med.references!) {
      referenceTiles.add(
        Padding(
          padding: EdgeInsets.fromLTRB(10, 0, 10, 5),
          child: InkWell(
            child: Card(
              elevation: 5,
              child: Padding(
                padding: EdgeInsets.all(20),
                child: Text(
                  item.title!,
                  textAlign: TextAlign.left,
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
            ),
            onTap: () => launchUrl(Uri.parse(item.url!)),
          ),
        ),
      );
    }

    referenceTiles.add(SizedBox(height: 20));
    return ExpansionTile(
      title: Text(
        S.current.medDetailsReferencesTileTitle,
        style: headerStyle,
      ),
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
  Widget drawExpansionTile(String title, String? content) {
    if (content == null) return Container();

    // TODO: MarkdownWidget: fix textConfig(TextAlign.justify), olConfig(index container)
    return ExpansionTile(
      title: Text(title, style: headerStyle),
      children: [
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
                    children: MarkdownGenerator().buildWidgets(content),
                  ),
                ),
              ),
              SizedBox(height: 20),
            ],
          ),
        )
      ],
    );
  }
}
