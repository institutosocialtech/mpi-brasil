import 'package:flutter/material.dart';

class Inicio extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Container(
              height: 80,
              color: Colors.green,
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                child: TextField(
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.all(10),
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(15)),
                    prefixIcon: Icon(Icons.search),
                    suffixIcon: Icon(Icons.mic),
                    fillColor: Colors.white,
                    filled: true,
                    hintText: "Pesquisar...",
                  ),
                ),
              ),
            ),
        Expanded(child: Container(
          child: Image.asset("assets/images/logo.jpg"),
        )),
      ],
    );
  }
}