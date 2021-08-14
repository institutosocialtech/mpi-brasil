import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/http_exception.dart';
import '../providers/auth.dart';

class ForgotPassword extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;

    return Scaffold(
        body: Stack(
      children: <Widget>[
        Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Colors.green[900],
                Colors.green[200],
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              stops: [0, 1],
            ),
          ),
        ),
        SingleChildScrollView(
          child: Container(
            height: deviceSize.height,
            width: deviceSize.width,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Flexible(
                  child: Container(
                    margin: EdgeInsets.only(bottom: 10),
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    child: Text(
                      "MPI Brasil",
                      textScaleFactor: 3,
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
                Flexible(
                  flex: deviceSize.width > 600 ? 3 : 2,
                  child: ForgotPasswordCard(),
                ),
              ],
            ),
          ),
        ),
      ],
    ));
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
                    onPressed: () => Navigator.of(context).pop(),
                    child: Text("OK")),
              ],
            ));
  }

  Future<void> _submit() async {
    if (!_formKey.currentState.validate()) {
      // invalid
      return;
    }

    _formKey.currentState.save();
    setState(() {
      _isLoading = true;
    });

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

    setState(() {
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;

    return _isLoading
        ? CircularProgressIndicator(
            backgroundColor: Colors.white,
            valueColor: AlwaysStoppedAnimation<Color>(Colors.green[800]),
          )
        : Card(
            child: Container(
              height: 420,
              constraints: BoxConstraints(minHeight: 420),
              width: deviceSize.width * 0.85,
              padding: EdgeInsets.all(15),
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    // title
                    Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        Text(
                          "Esqueceu a senha?",
                          textScaleFactor: 1.3,
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        Image.asset(
                          "assets/undraw/forgot_password.png",
                          height: 96,
                          width: 96,
                        ),
                      ],
                    ),
                    SizedBox(height: 10),
                    Text(
                      "Por favor, digite seu email de cadastro. Um link de verificação será enviado para seu email e a partir dele você poderá redefinir sua senha.",
                      textAlign: TextAlign.justify,
                    ),
                    SizedBox(height: 5),
                    // email field
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
                    SizedBox(
                      height: 20,
                    ),
                    // submit button
                    Column(
                      children: <Widget>[
                        ElevatedButton(
                          onPressed: _submit,
                          child: Text("Recuperar Senha"),
                          style: ElevatedButton.styleFrom(
                            primary: Colors.green,
                            textStyle: TextStyle(color: Colors.white),
                          ),
                        ),
                        SizedBox(height: 10),
                        InkWell(
                          child: Text(
                            "Voltar para o login",
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          onTap: () => Navigator.of(context).pop(),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          );
  }
}
