import 'package:flutter/material.dart';

class PainCard extends StatefulWidget {
  @override
  _PainCardState createState() => _PainCardState();
}

class _PainCardState extends State {
  final  headerStyle = TextStyle(fontWeight: FontWeight.bold, color: Colors.white);
  final  messageStyle = TextStyle(fontWeight: FontWeight.bold, color: Colors.white);
  double painLevel = 0;
  String painHeader = "";
  String painMessage = "";
  Color cardColor;

  @override
  Widget build(BuildContext context) {
    drawPainLevelBody(painLevel);

    return Padding(
      padding: const EdgeInsets.all(10),
      child: Card(
        elevation: 5,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[

            // Card Header
            Container(
              height: 40,
              color: Colors.black,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10,),
                    child: Text("NÍVEL DE DOR", textScaleFactor: 1.5, style: headerStyle,),
                  ),
                ],
              ),
            ),

            // Card Body
            Container(
              height: 150,
              color: cardColor,
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    Text(painHeader, textAlign: TextAlign.left, textScaleFactor: 1.4, style: headerStyle,),
                    SizedBox(height: 10,),
                    Text(painMessage, textAlign: TextAlign.justify, style: messageStyle,),
                  ],
                ),
              ),
            ),

            // Card Slider
            Container(
              height: 50,
              color: Colors.black12,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30),
                child: Slider(
                  min: 0,
                  max: 10,
                  divisions: 10,
                  value: painLevel,
                  activeColor: Colors.black,
                  inactiveColor: Colors.green,
                  onChanged: (_newPainLevel) => setState(() {
                    painLevel = _newPainLevel;
                    drawPainLevelBody(painLevel);
                  }),
                  label: painLevel.toInt().toString(),
                ),
              ),
            ),
            
          ],
        ),
      ),
    );
  }

  void drawPainLevelBody(double painLevel) {
    if (painLevel >= 0 && painLevel <= 3) {
      painHeader = "Dor Leve";
      painMessage = "Preferir analgésicos comuns, como Paracetamol (dose máxima: 2-4g/dia) ou Dipirona (até 1g de 6/6h).";
      cardColor = Colors.green;
    }
    else if (painLevel >= 4 && painLevel <=7) {
      painHeader = "Dor Moderada";
      painMessage = "Opióide fracos (como codeína ou tramadol). Se necessário, os analgésicos simples podem ser associados ou mantidos.";
      cardColor = Colors.orange;
    }
    else if (painLevel >= 8 && painLevel <=10) {
      painHeader = "Dor Forte";
      painMessage = "Opióides fortes (como morfina, metadona, fentanil e oxicodona). Se necessário, os analgésicos simples podem ser associados ou mantidos.";
      cardColor = Colors.red;
    }
  }

}
