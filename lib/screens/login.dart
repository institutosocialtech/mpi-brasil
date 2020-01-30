import 'package:flutter/material.dart';

class Login extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    // username field properties
    final usernameField = TextField(
      obscureText: false,
      decoration: InputDecoration(
        hintText: "Usuário",
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(30.0)),
        contentPadding: EdgeInsets.all(15),
      ),
    );

    // password field properties
    final passwordField = TextField(
      obscureText: true,
      decoration: InputDecoration(
        hintText: "Senha",
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(30.0)),
        contentPadding: EdgeInsets.all(15),
      ),
    );

    // login button properties
    final loginButton = Material(
        elevation: 2.0,
        color: Colors.blue,
        borderRadius: BorderRadius.circular(30),
        child: MaterialButton(
          onPressed: () {},
          padding: EdgeInsets.all(15),
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
              padding: const EdgeInsets.all(35.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Image.asset("assets/images/logo.png", fit: BoxFit.contain),
                  SizedBox(height: 50.0),
                  usernameField,
                  SizedBox(height: 20.0),
                  passwordField,
                  SizedBox(height: 30.0),
                  loginButton,
                  SizedBox(height: 30.0),
                ],
              ),
            ),
          ),
        ),
    );
  }
}