import 'package:flutter/material.dart';
import 'package:flutter_mailer/flutter_mailer.dart';
import 'package:grouped_buttons/grouped_buttons.dart';
import 'package:provider/provider.dart';
import '../providers/userpreferences.dart';

enum ReportAction { MED_INFO, TEXT_TYPO, APP_BUG, OTHER }

class ReportProblem {
  ReportAction _reportAction;

  Future<void> showReportDialog(BuildContext context, String medName) async {
    final action = await showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          elevation: 24,
          title: Text("Reportar um erro:"),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              RadioButtonGroup(
                labels: <String>[
                  "Informação",
                  "Ortografia",
                  "Bug",
                  "Outros",
                ],
                activeColor: Colors.green,
                onSelected: (String selected) {
                  switch (selected) {
                    case "Informação":
                      _reportAction = ReportAction.MED_INFO;
                      break;
                    case "Ortografia":
                      _reportAction = ReportAction.TEXT_TYPO;
                      break;
                    case "Bug":
                      _reportAction = ReportAction.APP_BUG;
                      break;
                    case "Outros":
                      _reportAction = ReportAction.OTHER;
                      break;
                  }
                },
              ),
            ],
          ),
          actions: <Widget>[
            // Cancel Button
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text("Cancelar"),
              style: TextButton.styleFrom(
                primary: Colors.green,
              ),
            ),

            // Send Button
            TextButton(
              onPressed: () => Navigator.of(context).pop(_reportAction),
              child: Text("Enviar"),
              style: TextButton.styleFrom(
                primary: Colors.white,
                backgroundColor: Colors.green,
              ),
            ),
          ],
        );
      },
    );

    switch (action) {
      case ReportAction.MED_INFO:
        Provider.of<UserPreferences>(context, listen: false)
            .sendReport(medName, 'MED_INFO');
        break;

      case ReportAction.TEXT_TYPO:
        Provider.of<UserPreferences>(context, listen: false)
            .sendReport(medName, 'TEXT_TYPO');
        break;

      case ReportAction.APP_BUG:
        Provider.of<UserPreferences>(context, listen: false)
            .sendReport(medName, 'APP_BUG');
        break;

      case ReportAction.OTHER:
        final mailOptions = MailOptions(
          body:
              'As informações do medicamento $medName apresentam o seguinte problema: ',
          subject: "Detectado um problema com o medicamento $medName",
          recipients: ['mpibrasil@pmosocial.org'],
          isHTML: true,
        );
        FlutterMailer.send(mailOptions);
        break;

      // do nothing if the user clicks cancel
      default:
        return;
    }

    // display report info
    final snackbar = SnackBar(
      content: Text("Obrigado por contribuir com a app!"),
    );
    ScaffoldMessenger.of(context).showSnackBar(snackbar);
  }
}
