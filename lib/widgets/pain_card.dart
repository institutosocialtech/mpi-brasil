import 'package:flutter/material.dart';
import 'package:markdown_widget/markdown_widget.dart';
import 'package:mpibrasil/constants.dart';

class PainCard extends StatefulWidget {
  @override
  _PainCardState createState() => _PainCardState();
}

class _PainCardState extends State {
  final headerStyle =
      TextStyle(fontWeight: FontWeight.bold, color: Colors.white);
  final messageStyle =
      TextStyle(fontWeight: FontWeight.bold, color: Colors.white);
  double painLevel = 1;
  String painHeader = "";
  String painHeaderDegree = "";
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
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Text(
                      "Escala Analgésica da Dor",
                      textScaleFactor: 1.5,
                      style: headerStyle,
                    ),
                  ),
                  IconButton(
                    icon: Icon(
                      Icons.info,
                      color: Colors.white,
                    ),
                    onPressed: () {
                      showPainInfo();
                    },
                  )
                ],
              ),
            ),

            // Card Body
            Container(
              height: 220,
              color: cardColor,
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Text(
                          painHeader,
                          textAlign: TextAlign.left,
                          textScaleFactor: 1.4,
                          style: headerStyle,
                        ),
                        Text(
                          painHeaderDegree,
                          textAlign: TextAlign.right,
                          textScaleFactor: 1.4,
                          style: headerStyle,
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 40,
                    ),
                    Text(
                      painMessage,
                      textAlign: TextAlign.justify,
                      textScaleFactor: 1.1,
                      style: messageStyle,
                    ),
                  ],
                ),
              ),
            ),

            // Card Slider
            Container(
              height: 120,
              color: Colors.black12,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    SliderTheme(
                      data: SliderTheme.of(context).copyWith(
                        activeTrackColor: Colors.black,
                        inactiveTrackColor: Colors.black12,
                        thumbColor: Colors.black,
                        overlayColor: Colors.black12,
                        tickMarkShape: RoundSliderTickMarkShape(),
                        activeTickMarkColor: Colors.black,
                        inactiveTickMarkColor: Colors.black12,
                        valueIndicatorShape: PaddleSliderValueIndicatorShape(),
                        valueIndicatorColor: Colors.black45,
                        valueIndicatorTextStyle: TextStyle(color: Colors.white),
                      ),
                      child: Slider(
                        min: 1,
                        max: 10,
                        divisions: 9,
                        value: painLevel,
                        onChanged: (_newPainLevel) => setState(() {
                          painLevel = _newPainLevel;
                          drawPainLevelBody(painLevel);
                        }),
                        label: getPainLevelLabel(painLevel),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 12),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: List.generate(
                            10, (index) => Text((index + 1).toString())),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(12, 10, 12, 0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Text(
                            "Escala Verbal Numérica",
                            textScaleFactor: 1.2,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void drawPainLevelBody(double painLevel) {
    if (painLevel >= 1 && painLevel <= 3) {
      cardColor = kColorMPIGreenOpaque;
      painHeader = "Dor Leve";
      painHeaderDegree = "1º Degrau";
      painMessage =
          "Preferir analgésicos comuns, como Paracetamol (dose máxima: 2-4g/dia) ou Dipirona (até 1g de 6/6h). Se necessário medicamentos adjuvantes podem ser associados.";
    } else if (painLevel >= 4 && painLevel <= 7) {
      cardColor = Colors.orange;
      painHeader = "Dor Moderada";
      painHeaderDegree = "2º Degrau";
      painMessage =
          "Opióide fracos (como codeína ou tramadol). Se necessário, os analgésicos simples e/ou adjuvantes podem ser associados ou mantidos.";
    } else if (painLevel >= 8 && painLevel <= 10) {
      cardColor = kColorMPIRed;
      painHeader = "Dor Intensa";
      painHeaderDegree = "3º Degrau";
      painMessage =
          "Opióides fortes (como morfina, metadona, fentanil e oxicodona). Se necessário, os analgésicos simples e/ou adjuvantes podem ser associados ou mantidos.";
    }
  }

  String getPainLevelLabel(double painLevel) {
    String label;

    if (painLevel >= 1 && painLevel <= 3) {
      label = "Leve";
    } else if (painLevel >= 4 && painLevel <= 7) {
      label = "Moderada";
    } else if (painLevel >= 8 && painLevel <= 10) {
      label = "Intensa";
    }
    return label;
  }

  void showPainInfo() {
    var popupMessage =
        "**Dor Aguda e Agudização da Dor Crônica:** Usar a escada de forma descendente, ou seja, usar o terceiro ou segundo degrau nos primeiros dias e, após resolução da causa de base (ex: cirurgia, trauma, etc.), ir descendo a escada analgésica da OMS.\n\n" +
            "**Dor Crônica:** Iniciar pelo degrau correpondente à intensidade da dor e, se não houver alívio da dor, subir a escada analgésica.\n\n" +
            "**Fonte:** Escada Analgésica da Dor\n(Organização Mundial de Saúde)";

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Informações"),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: MarkdownGenerator(
              data: popupMessage,
              styleConfig: StyleConfig(
                pConfig: PConfig(
                  selectable: false,
                  textConfig: TextConfig(textAlign: TextAlign.justify),
                ),
              ),
            ).widgets,
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text("Fechar"),
              style: TextButton.styleFrom(
                primary: kColorMPIGreen,
              ),
            )
          ],
        );
      },
    );
  }
}
