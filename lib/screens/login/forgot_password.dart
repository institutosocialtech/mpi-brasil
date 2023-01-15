import 'package:flutter/material.dart';
import 'package:mpibrasil/constants.dart';
import 'package:mpibrasil/screens/common/splashscreen.dart';
import 'package:provider/provider.dart';
import '../../models/http_exception.dart';
import '../../providers/auth.dart';

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
        title: Text("Erro"),
        content: Container(
          margin: EdgeInsets.only(top: 10),
          child: Text(message),
        ),
        actions: <Widget>[
          TextButton(
              onPressed: () => Navigator.of(context).pop(), child: Text("OK")),
        ],
      ),
    );
  }

  Future<void> _submit() async {
    // validate form
    if (!_formKey.currentState.validate()) return;
    // save form data
    _formKey.currentState.save();

    // display progress indicator
    setState(() => _isLoading = true);

    // send request
    try {
      await Provider.of<Auth>(context, listen: false).forgotPassword(email);
      // success msg
      final snackbar = SnackBar(
        content: Text("Solicitação enviada, por favor verifique seu email!"),
      );
      ScaffoldMessenger.of(context).showSnackBar(snackbar);
    } on HttpException catch (error) {
      var errorMessage = 'Falha ao tentar recuperar a senha!';
      if (error.toString() == "EMAIL_NOT_FOUND") {
        errorMessage = "O endereço de email digitado não está cadastrado!";
      }
      _showErrorDialog(errorMessage);
    } catch (error) {
      const errorMessage = 'Erro desconhecido';
      _showErrorDialog(errorMessage);
    }

    // hide progress indicator
    setState(() => _isLoading = false);
  }

  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;

    var titleStyle = TextStyle(
      color: kColorMPIGray,
      fontSize: 22,
      fontWeight: FontWeight.bold,
    );

    var messageStyle = TextStyle(
      color: kColorMPIGray,
      fontSize: 18,
    );

    var fPasswordMsg = "Por favor, digite seu email de cadastro. " +
        "Um link de verificação será enviado para seu email e a partir dele você poderá redefinir sua senha.";

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
                    "assets/undraw/account_amico.png",
                    height: 256,
                    width: 256,
                  ),

                  // title
                  Text("Esqueceu a senha?", style: titleStyle),

                  // message
                  SizedBox(height: 10),
                  Text(
                    fPasswordMsg,
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
                      labelText: "Email",
                      contentPadding: EdgeInsets.symmetric(horizontal: 10),
                    ),
                    validator: (value) {
                      if (value.isEmpty || !value.contains('@'))
                        return 'Email Inválido!';
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
                          "Recuperar Senha",
                          style: TextStyle(color: kColorMPIWhite),
                        ),
                        style: ElevatedButton.styleFrom(primary: kColorMPIBlue),
                      ),

                      // login button
                      SizedBox(height: 10),
                      InkWell(
                        onTap: () => Navigator.of(context).pop(),
                        child: Text(
                          "Voltar para o login",
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
