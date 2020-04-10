import 'package:flutter/material.dart';

class PainCard extends StatefulWidget {
  @override
  _PainCardState createState() => _PainCardState();
}

class _PainCardState extends State {
  final  headerStyle = TextStyle(fontWeight: FontWeight.bold, color: Colors.white);
  double painLevel = 0;
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
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Text("NÍVEL DE DOR", textScaleFactor: 1.5, style: headerStyle,),
                  ),
                ],
              ),
            ),

            // Card Body
            Container(
              height: 200,
              color: cardColor,
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: Text(painMessage, textScaleFactor: 1.3, style: headerStyle,),
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
                  onChanged: (_newPainLevel) => setState(() {painLevel = _newPainLevel; drawPainLevelBody(painLevel); }),
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
      painMessage = "Dor Leve";
      cardColor = Colors.green;
    }
    else if (painLevel >= 4 && painLevel <=7) {
      painMessage = "Dor Moderada";
      cardColor = Colors.orange;
    }
    else if (painLevel >= 8 && painLevel <=10) {
      painMessage = "Dor Forte";
      cardColor = Colors.red;
    }

  }

}
