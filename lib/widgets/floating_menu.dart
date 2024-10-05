import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:provider/provider.dart';
import 'package:share_plus/share_plus.dart';

import '../extensions.dart';
import '../constants.dart';
import '../models/med.dart';
import '../providers/userpreferences.dart';
import '../widgets/report_problem.dart';

class FloatingMenu extends StatelessWidget {
  final Med med;

  FloatingMenu({Key? key, required this.med}) : super(key: key);

  Widget build(BuildContext context) {
    var isFavorite =
        Provider.of<UserPreferences>(context, listen: true).isFavorite(med.id);

    return SpeedDial(
      // both default to 16
      childMargin: EdgeInsets.only(right: 18.0, bottom: 20.0),
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
      tooltip: S.current.floatingMenuTooltip,
      heroTag: S.current.floatingMenuHeroTag,
      backgroundColor: kColorMPIGreen,
      foregroundColor: kColorMPIWhite,
      elevation: 8.0,
      shape: CircleBorder(),
      children: [
        // favoritar
        SpeedDialChild(
          child: isFavorite
              ? Icon(Icons.star, color: kColorMPIWhite)
              : Icon(Icons.star_outline, color: kColorMPIWhite),
          backgroundColor: kColorMPIGreen,
          label: isFavorite ? S.current.delFavorite : S.current.addFavorite,
          labelStyle: TextStyle(fontSize: 18.0),
          onTap: () {
            Provider.of<UserPreferences>(context, listen: false)
                .toggleFavorite(med.id);

            final snackbar = SnackBar(
              content: Text(
                isFavorite
                    ? S.current.removedFromFavorites(med.name)
                    : S.current.addedToFavorites(med.name),
              ),
            );

            ScaffoldMessenger.of(context).showSnackBar(snackbar);
          },
        ),

        // compartilhar
        SpeedDialChild(
          child: Icon(Icons.share, color: kColorMPIWhite),
          backgroundColor: kColorMPIGreen,
          label: S.current.share,
          labelStyle: TextStyle(fontSize: 18.0),
          onTap: () => Share.share(buildShareMsg(context, med)),
        ),

        // reportar erro
        SpeedDialChild(
          child: Icon(Icons.report_problem, color: kColorMPIWhite),
          backgroundColor: kColorMPIGreen,
          label: S.current.reportError,
          labelStyle: TextStyle(fontSize: 18.0),
          onTap: () async {
            await ReportProblem().showReportDialog(context, med.name);
          },
        ),
      ],
    );
  }

  String buildShareMsg(BuildContext context, Med med) {
    final message = StringBuffer();

    message.writeln(S.current.shareMedSection(med.name));
    message.writeln(S.current.shareMedClassSection(med.medTypesToString()));

    // write avoid conditions if present
    if (med.hasConditionsToAvoid()) {
      message.writeln(
        S.current.shareMedAvoidConditionsSection(
          med.conditionsToAvoid!
              .map((condition) => '* ${condition.name}')
              .join('\n'),
        ),
      );
    }

    message.writeln(S.current.shareAppInfoSection(S.current.appUrl));
    return message.toString();
  }
}
