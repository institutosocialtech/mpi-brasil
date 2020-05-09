import 'package:flutter/material.dart';
import 'package:mpibrasil/widgets/drawer.dart';

class SearchPage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text('MPI Brasil'),
        titleSpacing: 0.0,
        elevation: 0,
      ),
      body: Column( children: [Container(
        height: 80,
        color: Colors.green,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
          child: TextField(
            decoration: InputDecoration(
              contentPadding: EdgeInsets.all(10),
              border: OutlineInputBorder(borderRadius: BorderRadius.circular(15)),
              suffixIcon: Icon(Icons.search),
              fillColor: Colors.white,
              filled: true,
              hintText: "Pesquisar...",
            ),
          ),
        ),
      ),
        Expanded(child: Container(
          child: Image.asset("assets/images/logo.jpg"),
        ))]),
      drawer: AppDrawer(),
    );


  }
}