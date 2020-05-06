import 'package:flutter/material.dart';
import 'package:mpibrasil/models/drug.dart';
import 'package:flutter_markdown/flutter_markdown.dart';


class AlternativesCard extends StatelessWidget {
  final DrugAlternatives item;
  AlternativesCard(
    this.item,
  );

  @override
  Widget build(BuildContext context) {
    var widgets = List<Widget>();

    widgets.add(Text(
      item.alternative,
      textAlign: TextAlign.left,
      style: TextStyle(fontWeight: FontWeight.bold),
    ));
    widgets.add(SizedBox(height: 10));
    // widgets.add(Text(item.description, textAlign: TextAlign.justify,));
    widgets.add(Center(child: MarkdownBody(data: item.description)));

    return Padding(
      padding: EdgeInsets.all(20),
      child: Column(children: widgets));
  }
}
