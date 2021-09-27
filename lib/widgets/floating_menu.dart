import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:mpibrasil/constants.dart';
import 'package:provider/provider.dart';
import 'package:share/share.dart';
import '../models/med.dart';
import '../providers/userpreferences.dart';
import '../widgets/report_problem.dart';

class FloatingMenu extends StatelessWidget {
  final Med med;
  FloatingMenu({Key key, this.med}) : super(key: key);

  Widget build(BuildContext context) {
    var isFavorite =
        Provider.of<UserPreferences>(context, listen: true).isFavorite(med.id);

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
      backgroundColor: kColorMPIGreen,
      foregroundColor: kColorMPIWhite,
      elevation: 8.0,
      shape: CircleBorder(),
      children: [
        // favoritar
        SpeedDialChild(
          child: isFavorite
              ? Icon(AntDesign.star, color: kColorMPIWhite)
              : Icon(AntDesign.staro, color: kColorMPIWhite),
          backgroundColor: kColorMPIGreen,
          label: isFavorite ? 'Remover favorito' : 'Adicionar favorito',
          labelStyle: TextStyle(fontSize: 18.0),
          onTap: () {
            Provider.of<UserPreferences>(context, listen: false)
                .toggleFavorite(med.id);
            if (isFavorite) {
              final snackbar = SnackBar(
                content: Text('"${med.name}" removido dos favoritos!'),
              );
              ScaffoldMessenger.of(context).showSnackBar(snackbar);
            }
          },
        ),

        // compartilhar
        SpeedDialChild(
          child: Icon(Icons.share, color: kColorMPIWhite),
          backgroundColor: kColorMPIGreen,
          label: 'Compartilhar',
          labelStyle: TextStyle(fontSize: 18.0),
          onTap: () {
            String shareCondicoes = "";
            if (med.conditionsToAvoid != null) {
              shareCondicoes = "\n\nCondições a serem evitadas:";
              for (MedAvoidCondition c in med.conditionsToAvoid) {
                shareCondicoes += "\n* ${c.name}";
              }
            }
            Share.share("${med.name}" +
                "\n\nClasse Farmacológica:\n${med.medTypesToString()}" +
                "$shareCondicoes" +
                "\n\nAcesse em:\nhttps://mpibrasil.codemagic.app");
          },
        ),

        // reportar erro
        SpeedDialChild(
          child: Icon(Icons.report_problem, color: kColorMPIWhite),
          backgroundColor: kColorMPIGreen,
          label: 'Reportar erro',
          labelStyle: TextStyle(fontSize: 18.0),
          onTap: () async {
            await ReportProblem().showReportDialog(context, "${med.name}");
          },
        ),
      ],
    );
  }
}
