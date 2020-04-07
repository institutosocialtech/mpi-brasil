import 'package:flutter/material.dart';
import 'package:mpibrasil/models/drug.dart';

class MonitorCard extends StatelessWidget {
  final DrugMonitor item;

  MonitorCard(
    this.item,
  );

  @override
  Widget build(BuildContext context) {
    var widgets = List<Widget>();

    widgets.add(Text(
      item.parameter,
      textAlign: TextAlign.left,
      style: TextStyle(fontWeight: FontWeight.bold),
    ));
    widgets.add(Container(height: 10));
    widgets.add(Text(item.description, textAlign: TextAlign.justify,));

    return Padding(
      padding: EdgeInsets.all(20),
      child: Column(children: widgets));
  }
}
