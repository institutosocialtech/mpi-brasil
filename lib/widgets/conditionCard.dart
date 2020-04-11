import 'package:flutter/material.dart';
import 'package:mpibrasil/models/drug.dart';

class ConditionCard extends StatelessWidget {
  final DrugAvoidCondition item;

  ConditionCard(
    this.item,
  );

  @override
  Widget build(BuildContext context) {
    var widgets = List<Widget>();

    widgets.add(Text(item.condition, textAlign: TextAlign.left,style: TextStyle(fontWeight: FontWeight.bold),));
    widgets.add(Container(height: 10));
    widgets.add(Text(item.description, textAlign: TextAlign.justify,));
    
    if (item.exception != null && item.exception.length > 0) {
      widgets.add(Container(height: 10));
      widgets.add(Text("Exceção", style: TextStyle(fontWeight: FontWeight.bold),));
      widgets.add(Text(item.exception));
    }
    
    return Padding(
      padding: EdgeInsets.all(20),
      child: Column(children: widgets));
  }

}
