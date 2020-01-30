import 'package:flutter/material.dart';

class TestPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text("MPI Brasil")),
        body: Center(
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  RaisedButton(
                    child: Text("Home"),
                    onPressed: () {
                      Navigator.pushNamed(context, '/home');
                    },
                  ),
                  RaisedButton(
                    child: Text("Login"),
                    onPressed: () {
                      Navigator.pushNamed(context, '/login');
                    },
                  ),
                  RaisedButton(
                    child: Text("Glossário"),
                    onPressed: () {
                      Navigator.pushNamed(context, '/glossario');
                    },
                  ),
                  RaisedButton(
                    child: Text("Medicamentos"),
                    onPressed: () {
                      Navigator.pushNamed(context, '/medicamentos');
                    },
                  ),
                  RaisedButton(
                    child: Text("Configurações"),
                    onPressed: () {
                      Navigator.pushNamed(context, '/settings');
                    },
                  ),
                ]
              )
          )
    );
  }
}
