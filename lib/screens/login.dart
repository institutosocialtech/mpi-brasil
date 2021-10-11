import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'package:mpibrasil/constants.dart';
import 'package:mpibrasil/providers/auth.dart';
import 'package:mpibrasil/models/http_exception.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool _isLoading;
  final GlobalKey<FormState> _formKey = GlobalKey();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  Map<String, String> _authData = {
    'email': '',
    'password': '',
  };

  // focus nodes
  FocusNode _fEmail;
  FocusNode _fPassword;
  FocusNode _fSubmit;

  // text styles
  final _labelStyle = TextStyle(
    color: kColorMPIGray,
    fontSize: 15,
  );

  final _linkStyle = TextStyle(
    color: kColorMPIGreen,
    fontSize: 15,
  );

  @override
  void initState() {
    super.initState();
    _fEmail = FocusNode();
    _fPassword = FocusNode();
    _fSubmit = FocusNode();
    _isLoading = false;
  }

  @override
  void dispose() {
    _fEmail.dispose();
    _fPassword.dispose();
    _fSubmit.dispose();
    super.dispose();
  }

  // display error message
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

  // validate form entry
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

  // form submit
  Future<void> _submit() async {
    if (!_formKey.currentState.validate()) {
      // invalid
      return;
    }

    // save form data
    _formKey.currentState.save();

    // display progress indicator
    setState(() => _isLoading = true);

    // try to login
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

    // hide progress indicator
    setState(() => _isLoading = false);
  }

  @override
  Widget build(BuildContext context) {
    // sign in button appearence
    final _buttonTextStyle = TextStyle(
      color: kColorMPIWhite,
      fontSize: 18,
      fontWeight: FontWeight.bold,
    );

    final _signInButtonStyle = ElevatedButton.styleFrom(
      primary: kColorMPIGreen,
    );

    // build widget
    return Scaffold(
      body: _isLoading
          ? Container(
              color: kColorMPIGreen,
              child: Center(
                child: CircularProgressIndicator(
                  backgroundColor: kColorMPIWhite,
                  valueColor: AlwaysStoppedAnimation<Color>(kColorMPIGreen),
                ),
              ),
            )
          : LayoutBuilder(
              builder: (context, constraints) => SingleChildScrollView(
                child: ConstrainedBox(
                  constraints: BoxConstraints(minHeight: constraints.maxHeight),
                  child: IntrinsicHeight(
                    child: GestureDetector(
                      onTap: () =>
                          FocusScope.of(context).requestFocus(new FocusNode()),
                      child: Container(
                        color: kColorMPIGreen,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            //
                            // lead image
                            //

                            Container(
                              height: 250,
                              child: SvgPicture.asset(
                                'assets/images/group3.svg',
                                fit: BoxFit.scaleDown,
                              ),
                            ),

                            //
                            // auth section
                            //

                            Expanded(
                              child: Container(
                                padding: EdgeInsets.all(20.0),
                                decoration:
                                    BoxDecoration(color: kColorMPIWhite),
                                child: Form(
                                  key: _formKey,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.stretch,
                                    children: [
                                      //
                                      // email field
                                      //

                                      TextFormField(
                                        focusNode: _fEmail,
                                        controller: _emailController,
                                        keyboardType:
                                            TextInputType.emailAddress,
                                        textInputAction: TextInputAction.next,
                                        decoration:
                                            InputDecoration(hintText: "Email"),
                                        validator: (value) =>
                                            _validateEntry('email', value),
                                        onSaved: (value) =>
                                            _authData['email'] = value,
                                        onFieldSubmitted: (text) {
                                          _fEmail.unfocus();
                                          FocusScope.of(context)
                                              .requestFocus(_fPassword);
                                        },
                                      ),

                                      //
                                      // password field
                                      //

                                      SizedBox(height: 20.0),
                                      TextFormField(
                                        obscureText: true,
                                        focusNode: _fPassword,
                                        controller: _passwordController,
                                        textInputAction: TextInputAction.done,
                                        decoration:
                                            InputDecoration(hintText: "Senha"),
                                        validator: (value) =>
                                            _validateEntry('password', value),
                                        onSaved: (value) =>
                                            _authData['password'] = value,
                                        onFieldSubmitted: (text) {
                                          _fPassword.unfocus();
                                          FocusScope.of(context)
                                              .requestFocus(_fSubmit);
                                        },
                                      ),

                                      //
                                      // forgot password
                                      //

                                      SizedBox(height: 5.0),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.end,
                                        children: [
                                          InkWell(
                                            onTap: () => Navigator.pushNamed(
                                                context, '/forgot_password'),
                                            child: Text('Esqueceu a senha?',
                                                style: _labelStyle),
                                          ),
                                        ],
                                      ),

                                      //
                                      // sign in button
                                      //

                                      SizedBox(height: 60.0),
                                      SizedBox(
                                        height: 55,
                                        child: ElevatedButton(
                                          onPressed: _submit,
                                          focusNode: _fSubmit,
                                          style: _signInButtonStyle,
                                          child: Text("Entrar",
                                              style: _buttonTextStyle),
                                        ),
                                      ),

                                      //
                                      // signUp section
                                      //
                                      Expanded(child: Container()),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Text('Novo usuário? ',
                                              style: _labelStyle),
                                          InkWell(
                                            onTap: () => Navigator.pushNamed(
                                                context, '/forgot_password'),
                                            child: Text('Cadastre aqui',
                                                style: _linkStyle),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),

                            //
                            // app version
                            //

                            Container(
                              color: kColorMPIWhite,
                              child: Text(
                                'v1.0.0',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: 14,
                                  color: kColorMPIGray,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
    );
  }
}
