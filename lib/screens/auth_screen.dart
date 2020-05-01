import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/http_exception.dart';
import '../providers/auth.dart';

enum AuthMode { SignUp, Login }

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

  AuthMode _authMode = AuthMode.Login;
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
      if (_authMode == AuthMode.Login) {
        await Provider.of<Auth>(context, listen: false).login(
          _authData['email'],
          _authData['password'],
        );
      } else {
        await Provider.of<Auth>(context, listen: false).signup(
          _authData['email'],
          _authData['password'],
        );
      }
    } on HttpException catch (error) {
      var errorMessage = 'A autenticação falhou!';

      switch (error.toString()) {
        case "INVALID_EMAIL":
          errorMessage = 'Email inválido!';
          break;
        case "EMAIL_NOT_FOUND":
          errorMessage = 'Email não encontrado!';
          break;
        case "EMAIL_EXISTS":
          errorMessage = 'Email já cadastrado!';
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

  String _validateEntry(String type, String value) {
    switch (type) {
      case 'email':
        if (value.isEmpty || !value.contains('@')) return 'Email Inválido';
        break;

      case 'password':
        if (value.isEmpty) return 'Digite sua Senha!';
        break;
    }
    return null;
  }

  void _switchAuthMode() {
    if (_authMode == AuthMode.Login) {
      setState(() {
        _authMode = AuthMode.SignUp;
        _formKey.currentState.reset();
      });
    } else {
      setState(() {
        _authMode = AuthMode.Login;
        _formKey.currentState.reset();
      });
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
              height: 420,
              constraints: BoxConstraints(minHeight: 420),
              width: deviceSize.width * 0.85,
              padding: EdgeInsets.all(15),
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
                          validator: (value) => _validateEntry('email', value),
                          onSaved: (value) => _authData['email'] = value,
                        ),
                        SizedBox(height: 10),
                        TextFormField(
                          obscureText: true,
                          controller: _passwordController,
                          decoration: InputDecoration(
                            labelText: "Senha",
                            contentPadding:
                                EdgeInsets.symmetric(horizontal: 10),
                          ),
                          validator: (value) =>
                              _validateEntry('password', value),
                          onSaved: (value) => _authData['password'] = value,
                        ),
                        if (_authMode == AuthMode.SignUp)
                          TextFormField(
                            enabled: _authMode == AuthMode.SignUp,
                            obscureText: true,
                            decoration: InputDecoration(
                              labelText: "Verificar Senha",
                              contentPadding:
                                  EdgeInsets.symmetric(horizontal: 10),
                            ),
                            validator: _authMode == AuthMode.SignUp
                                ? (value) {
                                    if (value.isEmpty ||
                                        value != _passwordController.text)
                                      return 'Senha não confere!';
                                  }
                                : null,
                          ),
                      ],
                    ),

                    // signIn button section
                    Column(children: <Widget>[
                      SizedBox(height: 5),
                      RaisedButton(
                        child: Text(_authMode == AuthMode.Login
                            ? 'Entrar'
                            : 'Cadastrar'),
                        onPressed: _submit,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                        padding:
                            EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                        color: Colors.green,
                        textColor: Colors.white,
                      ),
                      SizedBox(height: 5),
                      InkWell(
                        child: Text(_authMode == AuthMode.Login
                            ? 'Primeiro acesso? Cadastre aqui!'
                            : 'Já possui cadastro? Faça o Login'),
                        onTap: () => _switchAuthMode(),
                      ),
                      if (_authMode == AuthMode.Login)
                        InkWell(
                          child: Text("Esqueci minha senha"),
                          onTap: () => print('forgotPassword'),
                        ),
                    ]),
                  ],
                ),
              ),
            ),
          );
  }
}
