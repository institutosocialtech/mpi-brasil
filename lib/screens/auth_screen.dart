import 'package:flutter/material.dart';
import 'package:mpibrasil/models/http_exception.dart';
import 'package:provider/provider.dart';
import '../providers/auth.dart';

class AuthScreen extends StatelessWidget {
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
                      margin: EdgeInsets.only(bottom: 20),
                      padding:
                          EdgeInsets.symmetric(vertical: 5, horizontal: 60),
                      child: Text(
                        "MPI Brasil",
                        textScaleFactor: 3,
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  Flexible(
                    flex: deviceSize.width > 600 ? 2 : 1,
                    child: AuthCard(),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}

class AuthCard extends StatefulWidget {
  @override
  _AuthCardState createState() => _AuthCardState();
}

class _AuthCardState extends State<AuthCard> {
  final GlobalKey<FormState> _formKey = GlobalKey();
  final _passwordController = TextEditingController();
  var _isLoading = false;

  Map<String, String> _authData = {
    'email': '',
    'password': '',
  };

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
                FlatButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
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

    try {
      await Provider.of<Auth>(context, listen: false).login(
        _authData['email'],
        _authData['password'],
      );
    } on HttpException catch (error) {
      var errorMessage = 'A autenticação falhou!';

      switch (error.toString()) {
        case "INVALID_EMAIL":
          errorMessage = 'Email inválido!';
          break;
        case "EMAIL_NOT_FOUND":
          errorMessage = 'Email não encontrado!';
          break;
        case "INVALID_PASSWORD":
          errorMessage = 'Senha incorreta!';
          break;
        case "USER_DISABLED":
          errorMessage = 'Conta desativada por um administrador!';
          break;
      }
      _showErrorDialog(errorMessage);
    } catch (error) {
      const errorMessage = 'Erro desconhecido, tente novamente mais tarde';
      _showErrorDialog(errorMessage);
    }

    setState(() {
      _isLoading = false;
    });
  }

  String validateEntry(String type, String value) {
    switch (type) {
      case 'email':
        if (value.isEmpty || !value.contains('@')) return 'Email Inválido';
        break;

      case 'password':
        if (value.isEmpty) return 'Digite sua Senha!';
        break;
    }
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
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0),
            ),
            elevation: 8,
            child: Container(
              height: 360,
              constraints: BoxConstraints(minHeight: 360),
              width: deviceSize.width * 0.85,
              padding: EdgeInsets.all(20),
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    // username and pass section
                    Column(
                      children: <Widget>[
                        TextFormField(
                          obscureText: false,
                          keyboardType: TextInputType.emailAddress,
                          decoration: InputDecoration(
                            labelText: "Email",
                            contentPadding:
                                EdgeInsets.symmetric(horizontal: 10),
                          ),
                          validator: (value) => validateEntry('email', value),
                          onSaved: (value) => _authData['email'] = value,
                        ),
                        SizedBox(height: 20),
                        TextFormField(
                          obscureText: true,
                          controller: _passwordController,
                          decoration: InputDecoration(
                            labelText: "Senha",
                            contentPadding:
                                EdgeInsets.symmetric(horizontal: 10),
                          ),
                          validator: (value) =>
                              validateEntry('password', value),
                          onSaved: (value) => _authData['password'] = value,
                        ),
                      ],
                    ),

                    // signIn button section
                    Column(children: <Widget>[
                      SizedBox(height: 20),
                      RaisedButton(
                        child: Text("Entrar"),
                        onPressed: _submit,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                        padding:
                            EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                        color: Colors.green,
                        textColor: Colors.white,
                      ),
                      SizedBox(height: 10),
                      Text("Primeiro acesso? Cadastre aqui!"),
                      Text("Esqueci minha senha"),
                    ]),
                  ],
                ),
              ),
            ),
          );
  }
}
