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
  static Future<ReportProblemAction> reportProblemAction(
    BuildContext context,
    String drugName,
  ) async {
    final action = await showDialog(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext context) {
        return AlertDialog(
          elevation: 24,
          title: Text("Report a Problem"),
          content: Container(
            height: 240,
            child: RadioButtonGroup(
              labels: <String>[
                "Incomplete Information",
                "Wrong Information",
                "Option 3",
                "Option 4",
                "Others",
              ],
              activeColor: Colors.green,
              onSelected: (String selected) {
                switch (selected) {
                  case "Incomplete Information":
                    value = ReportProblemAction.INCOMP_INFO;
                    break;
                  case "Wrong Information":
                    value = ReportProblemAction.WRONG_INFO;
                    break;
                  case "Option 3":
                    value = ReportProblemAction.TYPE3;
                    break;
                  case "Option 4":
                    value = ReportProblemAction.TYPE4;
                    break;
                  case "Others":
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
                "No",
                style: TextStyle(color: Colors.green),
              ),
            ),
            //Send Button
            RaisedButton(
              color: Colors.green,
              onPressed: () => Navigator.of(context).pop(value),
              child: const Text(
                "Send",
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
        body: 'Teel us about what wrong with $drugName... ',
        // subject: "${drug.name}",
        subject: "Error with ${drugName}",
        recipients: ['yagocunhamartins@gmail.com'],
        isHTML: true,
        bccRecipients: ['yagocunhamartins@gmail.com'],
        ccRecipients: ['yagocunhamartins@gmail.com'],
        // attachments: [
        //   'path/to/image.png',
        // ],
      );

      await FlutterMailer.send(mailOptions);
    }
    value = null;
  }
}
