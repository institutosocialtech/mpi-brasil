import 'package:flutter/material.dart';
import 'package:mpibrasil/assets.dart';
import 'package:mpibrasil/constants.dart';
import 'package:mpibrasil/generated/l10n.dart';
import 'package:mpibrasil/models/http_exception.dart';
import 'package:mpibrasil/providers/auth.dart';
import 'package:mpibrasil/screens/common/splashscreen.dart';
import 'package:provider/provider.dart';

class ForgotPassword extends StatelessWidget {
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
                child: ForgotPasswordCard(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class ForgotPasswordCard extends StatefulWidget {
  @override
  _ForgotPasswordCardState createState() => _ForgotPasswordCardState();
}

class _ForgotPasswordCardState extends State<ForgotPasswordCard> {
  final GlobalKey<FormState> _formKey = GlobalKey();
  var _isLoading = false;
  var email;

  void _showErrorDialog(String message) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(S.current.error),
        content: Container(
          margin: EdgeInsets.only(top: 10),
          child: Text(message),
        ),
        actions: <Widget>[
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: Text(S.current.ok),
          ),
        ],
      ),
    );
  }

  Future<void> _submit() async {
    // validate form
    if (!_formKey.currentState!.validate()) return;
    // save form data
    _formKey.currentState!.save();

    // display progress indicator
    setState(() => _isLoading = true);

    // send request
    try {
      await Provider.of<Auth>(context, listen: false).forgotPassword(email);
      // success msg
      final snackbar = SnackBar(
        content: Text(S.current.forgotPasswordRequestSent),
      );
      ScaffoldMessenger.of(context).showSnackBar(snackbar);
    } on HttpException catch (error) {
      var errorMessage = error.message == "EMAIL_NOT_FOUND"
          ? S.current.forgotPasswordErrorEmailNotFound
          : S.current.forgotPasswordErrorGeneric;

      _showErrorDialog(errorMessage);
    } catch (error) {
      _showErrorDialog(S.current.errorUnexpected(error));
    }

    // hide progress indicator
    setState(() => _isLoading = false);
  }

  @override
  Widget build(BuildContext context) {
    var titleStyle = TextStyle(
      color: kColorMPIGray,
      fontSize: 22,
      fontWeight: FontWeight.bold,
    );

    var messageStyle = TextStyle(
      color: kColorMPIGray,
      fontSize: 18,
    );

    return _isLoading
        ? SplashScreen()
        : Container(
            padding: EdgeInsets.all(35.0),
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  // image
                  Image.asset(
                    MpiAssets.imgUndrawAccountAmico,
                    height: 256,
                    width: 256,
                  ),

                  // title
                  Text(S.current.forgotPasswordPageTitle, style: titleStyle),

                  // message
                  SizedBox(height: 10),
                  Text(
                    S.current.forgotPasswordPageBody,
                    style: messageStyle,
                    textAlign: TextAlign.center,
                  ),

                  // email field
                  SizedBox(height: 5),
                  TextFormField(
                    obscureText: false,
                    keyboardType: TextInputType.emailAddress,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: S.current.forgotPasswordEmailHintText,
                      contentPadding: EdgeInsets.symmetric(horizontal: 10),
                    ),
                    validator: (value) {
                      if (value == null ||
                          value.isEmpty ||
                          !value.contains('@'))
                        return S.current.forgotPasswordErrorInvalidEmail;
                      else
                        return null;
                    },
                    onSaved: (value) => email = value,
                  ),

                  // submit button
                  SizedBox(height: 20),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: <Widget>[
                      ElevatedButton(
                        onPressed: _submit,
                        child: Text(
                          S.current.forgotPasswordPageButtonSubmit,
                          style: TextStyle(color: kColorMPIWhite),
                        ),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: kColorMPIGreen,
                        ),
                      ),

                      // login button
                      SizedBox(height: 10),
                      InkWell(
                        onTap: () => Navigator.of(context).pop(),
                        child: Text(
                          S.current.forgotPasswordPageLabelBackToLogin,
                          textAlign: TextAlign.center,
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          );
  }
}
