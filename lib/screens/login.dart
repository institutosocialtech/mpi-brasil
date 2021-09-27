import 'package:flutter/material.dart';
import 'package:mpibrasil/constants.dart';
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
                    flex: 1,
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
                    flex: 2,
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
  var _privAccepted = false;

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
          TextButton(
            child: Text("Fechar"),
            onPressed: () => Navigator.of(context).pop(),
            style: TextButton.styleFrom(
              primary: kColorMPIWhite,
              backgroundColor: kColorMPIGreen,
            ),
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

    if (_authMode == AuthMode.SIGNUP) {
      if (!_tosAccepted) {
        _showErrorDialog(
            'Voce deve aceitar os termos de uso para poder utilizar a app.');
        return;
      }

      if (!_privAccepted) {
        _showErrorDialog(
            'Voce deve aceitar a política de privacidade para poder utilizar a app.');
        return;
      }
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
            backgroundColor: kColorMPIWhite,
            valueColor: AlwaysStoppedAnimation<Color>(kColorMPIGreen),
          )
        : Card(
            color: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0),
            ),
            elevation: 8,
            child: Container(
              width: deviceSize.width * 0.85,
              height: _authMode == AuthMode.LOGIN ? 290 : 400,
              constraints: BoxConstraints(maxHeight: 440),
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[
                    //
                    // textfield section
                    //

                    Column(
                      children: <Widget>[
                        //
                        // email field
                        //

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
                        SizedBox(height: 5),

                        //
                        // password field
                        //

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
                        SizedBox(height: 5),

                        //
                        // verify password field
                        //

                        if (_authMode == AuthMode.SIGNUP)
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
                      ],
                    ),

                    //
                    // tos and policy section
                    //

                    if (_authMode == AuthMode.SIGNUP)
                      Column(
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          //
                          // tos check
                          //
                          Row(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: <Widget>[
                              SizedBox(
                                width: 30,
                                height: 30,
                                child: Checkbox(
                                  value: _tosAccepted,
                                  checkColor: kColorMPIGreen,
                                  activeColor: Colors.black87,
                                  onChanged: (value) =>
                                      setState(() => _tosAccepted = value),
                                ),
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
                          ),

                          //
                          // priv policy check
                          //

                          Row(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: <Widget>[
                              SizedBox(
                                width: 30,
                                height: 30,
                                child: Checkbox(
                                  value: _privAccepted,
                                  checkColor: kColorMPIGreen,
                                  activeColor: Colors.black87,
                                  onChanged: (value) =>
                                      setState(() => _privAccepted = value),
                                ),
                              ),
                              Text('Eu aceito a '),
                              InkWell(
                                child: Text(
                                  'política de privacidade.',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    decoration: TextDecoration.underline,
                                  ),
                                ),
                                onTap: () => Navigator.of(context)
                                    .pushNamed('/privacy_policy'),
                              ),
                            ],
                          ),
                        ],
                      ),

                    //
                    // bottom section
                    //

                    Column(
                      children: <Widget>[
                        //
                        // signIn button
                        ElevatedButton(
                          child: Text(
                            _authMode == AuthMode.LOGIN
                                ? 'Entrar'
                                : 'Cadastrar',
                          ),
                          onPressed: _submit,
                          style: ElevatedButton.styleFrom(
                            primary: kColorMPIGreen,
                            textStyle: TextStyle(fontWeight: FontWeight.bold),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(5),
                            ),
                          ),
                        ),

                        //
                        // forgot password switch
                        SizedBox(height: 5),
                        if (_authMode == AuthMode.LOGIN)
                          InkWell(
                            child: Text(
                              "Esqueci minha senha",
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            onTap: () => Navigator.pushNamed(
                                context, '/forgot_password'),
                          ),

                        //
                        // Login/SignUp switch
                        InkWell(
                          onTap: () => _switchAuthMode(),
                          child: Text(
                            _authMode == AuthMode.LOGIN
                                ? 'Primeiro acesso? Cadastre aqui!'
                                : 'Já possui cadastro? Faça o Login aqui!',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
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
