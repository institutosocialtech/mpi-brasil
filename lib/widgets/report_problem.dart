import 'package:flutter/material.dart';
import 'package:flutter_mailer/flutter_mailer.dart';
import 'package:mpibrasil/constants.dart';
import 'package:mpibrasil/extensions.dart';
import 'package:mpibrasil/providers/userpreferences.dart';
import 'package:provider/provider.dart';

enum ReportAction { MED_INFO, TEXT_TYPO, APP_BUG, OTHER }

class ReportProblem {
  Future<void> showReportDialog(BuildContext context, String medName) async {
    ReportAction? _reportAction;

    final action = await showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          elevation: 24,
          title: Text(S.current.reportDialogTitle),
          content: StatefulBuilder(
            builder: (context, setState) {
              return Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  SwitchListTile(
                    title: Text(S.current.reportProblemTypeMedInfo),
                    value: _reportAction == ReportAction.MED_INFO,
                    onChanged: (value) {
                      if (_reportAction == ReportAction.MED_INFO) {
                        setState(() => _reportAction = null);
                        return;
                      }

                      setState(() => _reportAction = ReportAction.MED_INFO);
                    },
                  ),
                  SwitchListTile(
                    title: Text(S.current.reportProblemTypeSpelling),
                    value: _reportAction == ReportAction.TEXT_TYPO,
                    onChanged: (value) {
                      if (_reportAction == ReportAction.TEXT_TYPO) {
                        setState(() => _reportAction = null);
                        return;
                      }

                      setState(() => _reportAction = ReportAction.TEXT_TYPO);
                    },
                  ),
                  SwitchListTile(
                    title: Text(S.current.reportProblemTypeAppBug),
                    value: _reportAction == ReportAction.APP_BUG,
                    onChanged: (value) {
                      if (_reportAction == ReportAction.APP_BUG) {
                        setState(() => _reportAction = null);
                        return;
                      }

                      setState(() => _reportAction = ReportAction.APP_BUG);
                    },
                  ),
                  SwitchListTile(
                    title: Text(S.current.reportProblemTypeOther),
                    value: _reportAction == ReportAction.OTHER,
                    onChanged: (value) {
                      if (_reportAction == ReportAction.OTHER) {
                        setState(() => _reportAction = null);
                        return;
                      }

                      setState(() => _reportAction = ReportAction.OTHER);
                    },
                  ),
                ],
              );
            },
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text(S.current.reportDialogCancel),
              style: TextButton.styleFrom(
                foregroundColor: kColorMPIGreenOpaque,
              ),
            ),
            TextButton(
              onPressed: () => Navigator.of(context).pop(_reportAction),
              child: Text(S.current.reportDialogSendReport),
              style: TextButton.styleFrom(
                foregroundColor: kColorMPIWhite,
                backgroundColor: kColorMPIGreen,
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
          body: S.current.reportEmailBody(medName),
          subject: S.current.reportEmailSubject(medName),
          recipients: ['mpibrasil@socialtech.org.br'],
          isHTML: true,
        );
        FlutterMailer.send(mailOptions);
        break;

      // do nothing if the user clicks cancel
      default:
        return;
    }

    // display report info
    final snackbar = SnackBar(content: Text(S.current.reportMessageSent));
    ScaffoldMessenger.of(context).showSnackBar(snackbar);
  }
}
