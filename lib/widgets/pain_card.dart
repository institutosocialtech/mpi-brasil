import 'package:flutter/material.dart';
import 'package:markdown_widget/markdown_widget.dart';
import 'package:mpibrasil/constants.dart';
import 'package:mpibrasil/generated/l10n.dart';

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
  Color? cardColor;

  @override
  Widget build(BuildContext context) {
    drawPainLevelBody(painLevel, context);

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
                      S.current.painCardTitle,
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
                          drawPainLevelBody(painLevel, context);
                        }),
                        label: getPainLevelLabel(painLevel, context),
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
                            S.current.painCardScaleLabel,
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

  void drawPainLevelBody(double painLevel, BuildContext context) {
    if (painLevel >= 1 && painLevel <= 3) {
      cardColor = kColorMPIGreenOpaque;
      painHeader = S.current.painLevelLow;
      painHeaderDegree = S.current.painLevelLowRating;
      painMessage = S.current.painLevelLowMessage;
    } else if (painLevel >= 4 && painLevel <= 7) {
      cardColor = kColorMPIOrange;
      painHeader = S.current.painLevelModerate;
      painHeaderDegree = S.current.painLevelModerateRating;
      painMessage = S.current.painLevelModerateMessage;
    } else if (painLevel >= 8 && painLevel <= 10) {
      cardColor = kColorMPIRed;
      painHeader = S.current.painLevelHigh;
      painHeaderDegree = S.current.painLevelHighRating;
      painMessage = S.current.painLevelHighMessage;
    }
  }

  String getPainLevelLabel(double painLevel, BuildContext context) {
    if (painLevel >= 1 && painLevel <= 3) {
      return S.current.painCardScaleLevelLow;
    } else if (painLevel >= 4 && painLevel <= 7) {
      return S.current.painCardScaleLevelModerate;
    } else if (painLevel >= 8 && painLevel <= 10) {
      return S.current.painCardScaleLevelHigh;
    }

    return "";
  }

  void showPainInfo() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(S.current.painInfoDialogTitle),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            // TODO: MarkdownGenerator: fix textConfig(TextAlign.justify)
            children: MarkdownGenerator().buildWidgets(
              S.current.painInfoDialogContentMarkdown,
            ),
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text(S.current.painInfoDialogClose),
              style: TextButton.styleFrom(
                foregroundColor: kColorMPIGreen,
              ),
            )
          ],
        );
      },
    );
  }
}
