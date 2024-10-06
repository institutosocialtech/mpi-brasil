import 'package:flutter/material.dart';
import 'package:mpibrasil/constants.dart';
import 'package:mpibrasil/generated/l10n.dart';
import 'package:mpibrasil/models/http_exception.dart';
import 'package:mpibrasil/providers/auth.dart';
import 'package:provider/provider.dart';

class DeleteAccount extends StatelessWidget {
  const DeleteAccount({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: kColorMPIWhite,
      body: SingleChildScrollView(
        child: Container(
          height: deviceSize.height,
          width: deviceSize.width,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Flexible(
                flex: deviceSize.width > 600 ? 3 : 2,
                child: DeleteAccountCard(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class DeleteAccountCard extends StatefulWidget {
  const DeleteAccountCard({Key? key}) : super(key: key);

  @override
  State<DeleteAccountCard> createState() => _DeleteAccountCardState();
}

class _DeleteAccountCardState extends State<DeleteAccountCard> {
  var _isLoading = false;
  var email;

  void _showErrorDialog(String message) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(S.current.delAccountErrorDialogTitle),
        content: Container(
          margin: EdgeInsets.only(top: 10),
          child: Text(message),
        ),
        actions: <Widget>[
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: Text(S.current.delAccountErrorDialogActionOk),
          ),
        ],
      ),
    );
  }

  Future<void> _deleteAccount(bool hasConfirmedAccountDeletion) async {
    if (!hasConfirmedAccountDeletion) return;

    // display progress indicator
    setState(() => _isLoading = true);

    try {
      // delete user account
      await Provider.of<Auth>(context, listen: false).deleteAccount();

      // display success message
      await showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text(S.current.appTitle),
          content: Container(
            margin: EdgeInsets.only(top: 10),
            child: Text(S.current.delAccountSuccessMessage),
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text(S.current.delAccountSuccessDialogActionOk),
            ),
          ],
        ),
      );

      Navigator.pop(context);
      Navigator.pushReplacementNamed(context, '/');

      // register logout
      await Provider.of<Auth>(context, listen: false).logout();
    } on HttpException catch (error) {
      String errorMessage;

      switch (error.toString()) {
        case 'INVALID_ID_TOKEN':
          errorMessage = S.current.delAccountErrorInvalidIdToken;
          break;

        case 'MISSING_ID_TOKEN':
          errorMessage = S.current.delAccountErrorMissingIdToken;
          break;

        case 'USER_NOT_FOUND':
          errorMessage = S.current.delAccountErrorUserNotFound;
          break;

        default:
          errorMessage = S.current.delAccountErrorGeneric;
      }

      _showErrorDialog(errorMessage);
    } catch (error) {
      _showErrorDialog(S.current.errorUnexpected(error.toString()));
    }

    // hide progress indicator
    setState(() => _isLoading = false);
  }

  @override
  Widget build(BuildContext context) {
    final bodyTextStyle = TextStyle(
      color: kColorMPIGray,
      fontSize: 20,
      fontWeight: FontWeight.normal,
    );

    final titleTextStyle = TextStyle(
      color: kColorMPIGray,
      fontSize: 22,
      fontWeight: FontWeight.bold,
    );

    return Container(
      padding: EdgeInsets.all(35.0),
      child: _isLoading
          ? Center(
              child: CircularProgressIndicator(
                backgroundColor: kColorMPIWhite,
                valueColor: AlwaysStoppedAnimation<Color>(kColorMPIGreen),
              ),
            )
          : Column(
              children: [
                // page title
                Padding(
                  padding: EdgeInsets.only(bottom: 10.0, top: 50.0),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      S.current.delAccountPageTitle,
                      style: titleTextStyle,
                    ),
                  ),
                ),

                // page body
                Padding(
                  padding: const EdgeInsets.only(bottom: 10.0),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      S.current.delAccountPageBody,
                      style: bodyTextStyle,
                    ),
                  ),
                ),

                Padding(
                  padding: const EdgeInsets.only(bottom: 25.0),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      S.current.delAccountPageFooter,
                      style: bodyTextStyle,
                    ),
                  ),
                ),

                Expanded(
                  child: Container(),
                ),

                // action buttons
                Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    ElevatedButton(
                      onPressed: () => Navigator.of(context).pop(),
                      child: Text(S.current.delAccountPageButtonCancel),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: kColorMPIGreen,
                        foregroundColor: kColorMPIWhite,
                      ),
                    ),
                    ElevatedButton(
                      onPressed: () => _showConfirmDeleteDialog(context),
                      child: Text(S.current.delAccountPageButtonConfirm),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: kColorMPIRed,
                        foregroundColor: kColorMPIWhite,
                      ),
                    ),
                  ],
                )
              ],
            ),
    );
  }

  Future<void> _showConfirmDeleteDialog(BuildContext context) async {
    bool hasConfirmedAccountDeletion = await showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return AlertDialog(
          title: Text(S.current.delAccountConfirmDialogTitle),
          content: Text(S.current.delAccountConfirmDialogContentText),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(false),
              child: Text(S.current.delAccountConfirmDialogActionCancel),
            ),
            TextButton(
              onPressed: () => Navigator.of(context).pop(true),
              child: Text(S.current.delACcountConfirmDialogActionConfirm),
              style: TextButton.styleFrom(foregroundColor: kColorMPIRed),
            ),
          ],
        );
      },
    );

    _deleteAccount(hasConfirmedAccountDeletion);
  }
}
