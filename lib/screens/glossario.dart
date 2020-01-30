import 'package:flutter/material.dart';

class Glossario extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    return Scaffold(
        appBar: AppBar(
          title: Text("MPI Brasil"),
        ),
        body: Center(
          child: Text("Glossário")
        )
    );
  }
}