import 'package:flutter/material.dart';
import 'package:flutter_mailer/flutter_mailer.dart';
import 'package:grouped_buttons/grouped_buttons.dart';

enum ReportProblemAction { CANCEL, UPDATE_INFO, WRONG_INFO, ERROR_APP, OTHER }
ReportProblemAction value;

class ReportProblem {
  Future<void> reportProblemAction(BuildContext context, String medName) async {
    final action = await showDialog(
      context: context,
      barrierDismissible: true,
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
                      value = ReportProblemAction.UPDATE_INFO;
                      break;
                    case "Ortografia":
                      value = ReportProblemAction.WRONG_INFO;
                      break;
                    case "Bug":
                      value = ReportProblemAction.ERROR_APP;
                      break;
                    case "Outros":
                      value = ReportProblemAction.OTHER;
                      break;
                    default:
                      value = ReportProblemAction.CANCEL;
                  }
                },
              ),
            ],
          ),
          actions: <Widget>[
            //Cancel Button
            FlatButton(
              onPressed: () =>
                  Navigator.of(context).pop(ReportProblemAction.CANCEL),
              child: const Text(
                "Cancelar",
                style: TextStyle(color: Colors.green),
              ),
            ),
            //Send Button
            RaisedButton(
              color: Colors.green,
              onPressed: () => Navigator.of(context).pop(value),
              child: const Text(
                "Enviar",
                style: TextStyle(color: Colors.white),
              ),
            ),
          ],
        );
      },
    );

    if (action == ReportProblemAction.UPDATE_INFO) {
      print(action);
    } else if (action == ReportProblemAction.WRONG_INFO) {
      print(action);
    } else if (action == ReportProblemAction.ERROR_APP) {
      print(action);
    } else if (action == ReportProblemAction.OTHER) {
      print(action);
      final MailOptions mailOptions = MailOptions(
        body:
            'As informações do medicamento $medName apresentam o seguinte problema: ',
        // subject: "${med.name}",
        subject: "Detectado um problema com o medicamento $medName",
        recipients: ['mpibrasil@pmosocial.org'],
        isHTML: true,
      );

      FlutterMailer.send(mailOptions);
    }
  }
}
