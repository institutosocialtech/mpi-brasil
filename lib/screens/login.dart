import 'package:flutter/material.dart';

class Login extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    // username field properties
    final usernameField = TextField(
      obscureText: false,
      decoration: InputDecoration(
        labelText: "Usuário",
        hintText: "Usuário",
        contentPadding: EdgeInsets.symmetric(horizontal: 10),
      ),
    );

    // password field properties
    final passwordField = TextField(
      obscureText: true,
      decoration: InputDecoration(
        labelText: "Senha",
        hintText: "Senha",
        contentPadding: EdgeInsets.symmetric(horizontal: 10),
      ),
    );

    // login button properties
    final loginButton = Material(
        elevation: 2.0,
        color: Colors.green,
        borderRadius: BorderRadius.circular(5),
        child: MaterialButton(
          onPressed: () {},
          padding: EdgeInsets.all(10),
          child: Text(
            "Entrar",
            style: TextStyle(color: Colors.white),
            textAlign: TextAlign.center,
          ),
        )
    );

    return Scaffold(
        body: Center(
          child: Container(
            color: Colors.white,
            child: Padding(
              padding: const EdgeInsets.all(50),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Image.asset("assets/images/logo-green.png", fit: BoxFit.contain),
                  SizedBox(height: 50.0),
                  usernameField,
                  SizedBox(height: 10.0),
                  passwordField,
                  SizedBox(height: 50.0),
                  loginButton,
                ],
              ),
            ),
          ),
        ),
    );
  }
}