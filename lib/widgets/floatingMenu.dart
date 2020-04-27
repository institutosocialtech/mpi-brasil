import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:share/share.dart';
import '../models/report_problem.dart';
import '../models/drug.dart';

class FloatingMenu extends StatelessWidget {
  final Drug drug;
  FloatingMenu({Key key, this.drug}) : super(key: key);

  Widget build(BuildContext context) {
    return SpeedDial(
      // both default to 16
      marginRight: 18,
      marginBottom: 20,
      animatedIcon: AnimatedIcons.menu_close,
      animatedIconTheme: IconThemeData(size: 22.0),
      // this is ignored if animatedIcon is non null
      // child: Icon(Icons.add),
      visible: true,
      // If true user is forced to close dial manually
      // by tapping main button and overlay is not rendered.
      closeManually: false,
      curve: Curves.bounceIn,
      overlayColor: Colors.black,
      overlayOpacity: 0.5,
      tooltip: 'Speed Dial',
      heroTag: 'speed-dial-hero-tag',
      backgroundColor: Colors.green,
      foregroundColor: Colors.white,
      elevation: 8.0,
      shape: CircleBorder(),
      children: [
        // favoritar
        SpeedDialChild(
            child: Icon(Icons.favorite),
            backgroundColor: Colors.green,
            label: 'Favorito',
            labelStyle: TextStyle(fontSize: 18.0),
            onTap: () => print('favorito pressed')),

        // compartilhar
        SpeedDialChild(
          child: Icon(Icons.share),
          backgroundColor: Colors.green,
          label: 'Compartilhar',
          labelStyle: TextStyle(fontSize: 18.0),
          onTap: () {
            String shareCondicoes = "";
            if (drug.avoid_conditions != null) {
              shareCondicoes = "\n\nCondições a serem evitadas:";
              for (DrugAvoidCondition c in drug.avoid_conditions) {
                // TODO: remover hack depois
                if (c.criticalLevel == 1) {
                  continue;
                }
                shareCondicoes += "\n* ${c.condition}";
              }
            }
            Share.share("${drug.name}" +
                "\n\nClasse Farmacológica:\n${drug.drugTypesToString()}" +
                "$shareCondicoes" +
                "\n\nAcesse em:\nhttps://mpibrasil.codemagic.app");
          },
        ),

        // reportar erro
        SpeedDialChild(
          child: Icon(Icons.report_problem),
          backgroundColor: Colors.green,
          label: 'Reportar Erro',
          labelStyle: TextStyle(fontSize: 18.0),
          onTap: () async {
            await ReportProblem().reportProblemAction(context, "${drug.name}");
          },
        ),
      ],
    );
  }
}
