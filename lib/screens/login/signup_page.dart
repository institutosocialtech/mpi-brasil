import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:provider/provider.dart';
import 'package:mpibrasil/constants.dart';
import 'package:mpibrasil/models/http_exception.dart';
import 'package:mpibrasil/providers/auth.dart';
import 'package:mpibrasil/screens/common/splashscreen.dart';

class SignUpPage extends StatefulWidget {
  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  // draw util
  bool _isLoading;

  // auth
  Map<String, String> _authData = {
    'email': '',
    'password': '',
  };

  // controllers
  final GlobalKey<FormState> _formKey = GlobalKey();
  final _emailController = TextEditingController();
  final _pwdController = TextEditingController();
  final _pwdVerifyController = TextEditingController();

  // focus nodes
  FocusNode _fEmail;
  FocusNode _fPwd;
  FocusNode _fPwdVerify;
  FocusNode _fSubmit;

  // init
  @override
  void initState() {
    super.initState();
    _fEmail = FocusNode();
    _fPwd = FocusNode();
    _fPwdVerify = FocusNode();
    _fSubmit = FocusNode();
    _isLoading = false;
  }

  // dispose
  @override
  void dispose() {
    _fEmail.dispose();
    _fPwd.dispose();
    _fPwdVerify.dispose();
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
        if (value.isEmpty || !value.contains('@')) return 'Email inválido';
        break;

      case 'password':
        if (value.isEmpty) return 'Digite sua senha!';
        if (value.length < 6) return 'A senha deve ter pelo menos 6 dígitos';
        break;

      case 'passVerify':
        if (value.isEmpty) return 'Digite sua senha novamente!';
        if (value != _pwdController.text) return 'Senha não confere!';
        if (value.length < 6) return 'A senha deve ter pelo menos 6 dígitos';
        break;
    }
    return null;
  }

  // submit signUp
  Future<void> _submit() async {
    // validate form
    if (!_formKey.currentState.validate()) return;
    // save form data
    _formKey.currentState.save();
    // display progress indicator
    setState(() => _isLoading = true);

    // try to signUp
    // try to login
    try {
      await Provider.of<Auth>(context, listen: false).signup(
        _authData['email'],
        _authData['password'],
      );
    } on HttpException catch (error) {
      var errorMessage;

      // trim firebase error message
      var endIndex = error.message.indexOf(" :", 0);
      var errorCode = error.message.substring(0, endIndex);

      switch (errorCode) {
        case "INVALID_EMAIL":
          errorMessage = 'Email inválido!';
          break;
        case "EMAIL_EXISTS":
          errorMessage = 'Email já cadastrado!';
          break;
        case "WEAK_PASSWORD":
          errorMessage = 'Senha deve ter ao menos 6 caracteres!';
          break;
        default:
          errorMessage = 'A autenticação falhou!';
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

  // draw screen
  @override
  Widget build(BuildContext context) {
    // sign in button text style
    final _buttonTextStyle = TextStyle(
      color: kColorMPIWhite,
      fontSize: 18,
      fontWeight: FontWeight.bold,
    );

    // sign in button appearance
    final _signUpButtonStyle = ElevatedButton.styleFrom(
      primary: kColorMPIGreen,
    );

    // text styles
    final _labelStyle = TextStyle(
      color: kColorMPIGray,
      fontSize: 15,
    );

    // link styles
    final _linkStyle = TextStyle(
      color: kColorMPIGreen,
      fontSize: 15,
    );

    return Scaffold(
      body: _isLoading
          ? SplashScreen()
          : LayoutBuilder(
              builder: (context, constraints) => SingleChildScrollView(
                child: ConstrainedBox(
                  constraints: BoxConstraints(minHeight: constraints.maxHeight),
                  child: IntrinsicHeight(
                    child: GestureDetector(
                      child: Container(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            // header
                            _drawMPIHeader(),

                            // auth section
                            Expanded(
                              child: Container(
                                padding: EdgeInsets.all(20.0),
                                child: Form(
                                  key: _formKey,
                                  child: Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.stretch,
                                    children: [
                                      // email field
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
                                              .requestFocus(_fPwd);
                                        },
                                      ),

                                      // password field
                                      TextFormField(
                                        obscureText: true,
                                        focusNode: _fPwd,
                                        controller: _pwdController,
                                        textInputAction: TextInputAction.next,
                                        decoration:
                                            InputDecoration(hintText: "Senha"),
                                        validator: (value) =>
                                            _validateEntry('password', value),
                                        onSaved: (value) =>
                                            _authData['password'] = value,
                                        onFieldSubmitted: (value) {
                                          _fPwd.unfocus();
                                          FocusScope.of(context)
                                              .requestFocus(_fPwdVerify);
                                        },
                                      ),

                                      // password verify field
                                      TextFormField(
                                        obscureText: true,
                                        focusNode: _fPwdVerify,
                                        controller: _pwdVerifyController,
                                        textInputAction: TextInputAction.done,
                                        decoration: InputDecoration(
                                            hintText: "Repetir senha"),
                                        validator: (value) =>
                                            _validateEntry('passVerify', value),
                                        onFieldSubmitted: (text) {
                                          _fPwdVerify.unfocus();
                                          FocusScope.of(context)
                                              .requestFocus(_fSubmit);
                                        },
                                      ),

                                      // sign up button
                                      SizedBox(
                                        height: 55,
                                        child: ElevatedButton(
                                          onPressed: _submit,
                                          style: _signUpButtonStyle,
                                          child: Text(
                                            "Registrar",
                                            style: _buttonTextStyle,
                                          ),
                                        ),
                                      ),
                                      // login button
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Text(
                                            "Já possui uma conta? ",
                                            style: _labelStyle,
                                          ),
                                          InkWell(
                                            child: Text(
                                              'Fazer login.',
                                              style: _linkStyle,
                                            ),
                                            onTap: () =>
                                                Navigator.of(context).pop(),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),

                            // footer
                            _drawAppVersion(),
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

  Widget _drawMPIHeader() {
    var headerColorFilter = ColorFilter.mode(
      kColorMPIGreen,
      BlendMode.multiply,
    );

    return Container(
      height: 250,

      // background
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage('assets/images/bg_shadow.png'),
          colorFilter: headerColorFilter,
          alignment: Alignment.topLeft,
          fit: BoxFit.fitWidth,
        ),
      ),

      // logo
      child: SvgPicture.asset(
        'assets/images/group3.svg',
        fit: BoxFit.scaleDown,
      ),
    );
  }

  Widget _drawAppVersion() {
    return Container(
      height: 50,
      alignment: Alignment.bottomCenter,
      child: FutureBuilder<PackageInfo>(
        future: PackageInfo.fromPlatform(),
        builder: (context, snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.done:
              return Text(
                'v${snapshot.data.version}',
                textAlign: TextAlign.center,
                style: Theme.of(context)
                    .textTheme
                    .caption
                    .copyWith(color: kColorMPIGray),
              );
            default:
              return Text('');
          }
        },
      ),
    );
  }
}
