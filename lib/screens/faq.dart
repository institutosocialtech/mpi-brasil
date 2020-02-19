import 'package:flutter/material.dart';

class FAQ extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('MPI Brasil'),
          titleSpacing: 0.0,
        ),
        body: Center(
          child: Text("FAQ")
        )
    );
  }
}