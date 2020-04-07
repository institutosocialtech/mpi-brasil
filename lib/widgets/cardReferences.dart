import 'package:flutter/material.dart';
import 'package:mpibrasil/models/drug.dart';

class ReferencesCard extends StatelessWidget {
  final DrugReference item;

  ReferencesCard(
    this.item,
  );

  @override
  Widget build(BuildContext context) {
    var widgets = List<Widget>();

    widgets.add(Text(
      item.description,
      textAlign: TextAlign.left,
      style: TextStyle(fontWeight: FontWeight.bold),
    ));

    return Padding(
      padding: EdgeInsets.all(20),
      child: Column(children: widgets));
  }
}
