import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/http_exception.dart';
import '../providers/auth.dart';

enum AuthMode { SIGNUP, LOGIN }

class LoginPage extends StatelessWidget {
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
                      padding: EdgeInsets.only(bottom: 10),
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
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _passwordVerifyController = TextEditingController();

  var _isLoading = false;
  var _tosAccepted = false;

  AuthMode _authMode = AuthMode.LOGIN;
  Map<String, String> _authData = {
    'email': '',
    'password': '',
  };

  void _showErrorDialog(String message) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("Erro"),
        content: Text(message),
        actions: <Widget>[
          FlatButton(
            color: Colors.green,
            child: Text("Fechar"),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ],
      ),
    );
  }

  Future<void> _submit() async {
    if (!_formKey.currentState.validate()) {
      // invalid
      return;
    }

    _formKey.currentState.save();

    if (_authMode == AuthMode.SIGNUP && !_tosAccepted) {
      _showErrorDialog(
          'Voce deve aceitar os termos de uso para poder utilizar a app.');
      return;
    }

    setState(() {
      _isLoading = true;
    });

    try {
      if (_authMode == AuthMode.LOGIN) {
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
    if (_authMode == AuthMode.LOGIN) {
      setState(() {
        _authMode = AuthMode.SIGNUP;
        _formKey.currentState.reset();
      });
    } else {
      setState(() {
        _authMode = AuthMode.LOGIN;
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
            color: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0),
            ),
            elevation: 8,
            child: Container(
              width: deviceSize.width * 0.85,
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    Column(
                      children: <Widget>[
                        TextFormField(
                          controller: _emailController,
                          obscureText: false,
                          keyboardType: TextInputType.emailAddress,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(),
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
                            border: OutlineInputBorder(),
                            labelText: "Senha",
                            contentPadding:
                                EdgeInsets.symmetric(horizontal: 10),
                          ),
                          validator: (value) =>
                              _validateEntry('password', value),
                          onSaved: (value) => _authData['password'] = value,
                        ),
                        if (_authMode == AuthMode.SIGNUP)
                          Column(
                            children: <Widget>[
                              SizedBox(height: 10),
                              TextFormField(
                                controller: _passwordVerifyController,
                                enabled: _authMode == AuthMode.SIGNUP,
                                obscureText: true,
                                decoration: InputDecoration(
                                  border: OutlineInputBorder(),
                                  labelText: "Verificar Senha",
                                  contentPadding:
                                      EdgeInsets.symmetric(horizontal: 10),
                                ),
                                validator: _authMode == AuthMode.SIGNUP
                                    ? (value) {
                                        if (value.isEmpty ||
                                            value != _passwordController.text)
                                          return 'Senha não confere!';
                                        else
                                          return null;
                                      }
                                    : null,
                              ),
                              Row(
                                mainAxisSize: MainAxisSize.max,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: <Widget>[
                                  Checkbox(
                                    value: _tosAccepted,
                                    checkColor: Colors.green,
                                    activeColor: Colors.black87,
                                    onChanged: (value) =>
                                        setState(() => _tosAccepted = value),
                                  ),
                                  Text('Eu aceito os '),
                                  InkWell(
                                    child: Text(
                                      'termos de uso.',
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        decoration: TextDecoration.underline,
                                      ),
                                    ),
                                    onTap: () =>
                                        Navigator.of(context).pushNamed('/tos'),
                                  ),
                                ],
                              )
                            ],
                          ),
                      ],
                    ),
                    // signIn button section
                    Column(children: <Widget>[
                      RaisedButton(
                        child: Text(_authMode == AuthMode.LOGIN
                            ? 'Entrar'
                            : 'Cadastrar'),
                        color: Colors.green,
                        textColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5),
                        ),
                        onPressed: _submit,
                      ),
                      InkWell(
                        child: Text(_authMode == AuthMode.LOGIN
                            ? 'Primeiro acesso? Cadastre aqui!'
                            : 'Já possui cadastro? Faça o Login'),
                        onTap: () => _switchAuthMode(),
                      ),
                      if (_authMode == AuthMode.LOGIN)
                        InkWell(
                          child: Text("Esqueci minha senha"),
                          onTap: () =>
                              Navigator.pushNamed(context, '/forgot_password'),
                        ),
                    ]),
                  ],
                ),
              ),
            ),
          );
  }
}
