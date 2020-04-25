import 'package:flutter/material.dart';
import 'package:flutter_mailer/flutter_mailer.dart';
import 'package:grouped_buttons/grouped_buttons.dart';

enum ReportProblemAction {
  CANCEL,
  INCOMP_INFO,
  WRONG_INFO,
  TYPE3,
  TYPE4,
  OTHER
}
ReportProblemAction value;

class ReportProblem {

  Future<void> reportProblemAction( BuildContext context, String drugName) async {
    final action = await showDialog(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext context) {
        return AlertDialog(
          elevation: 24,
          title: Text("Informar um problema."),
          content: Container(
            height: 240,
            child: RadioButtonGroup(
              labels: <String>[
                "Informação incompleta",
                "Informação incorreta",
                "Dificil visualização",
                "Outro problema",
              ],
              activeColor: Colors.green,
              onSelected: (String selected) {
                switch (selected) {
                  case "Informação incompleta":
                    value = ReportProblemAction.INCOMP_INFO;
                    break;
                  case "Informação incorreta":
                    value = ReportProblemAction.WRONG_INFO;
                    break;
                  case "Dificil visualização":
                    value = ReportProblemAction.TYPE3;
                    break;
                  case "Outro problema":
                    value = ReportProblemAction.OTHER;
                    break;
                  default:
                    value = ReportProblemAction.CANCEL;
                }
              },
            ),
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

    if (action == ReportProblemAction.INCOMP_INFO) {
      print(action);
    } else if (action == ReportProblemAction.WRONG_INFO) {
      print(action);
    } else if (action == ReportProblemAction.TYPE3) {
      print(action);
    } else if (action == ReportProblemAction.TYPE4) {
      print(action);
    } else if (action == ReportProblemAction.OTHER) {
      print(action);
      final MailOptions mailOptions = MailOptions(
        body: 'As informações do medicamento $drugName apresentam o seguinte problema: ',
        // subject: "${drug.name}",
        subject: "Detectado um problema com o medicamento $drugName",
        recipients: ['mpibrasil@pmosocial.org'],
        isHTML: true,
      );

      FlutterMailer.send(mailOptions);
    }
  }
}
