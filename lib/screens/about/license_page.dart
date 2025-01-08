import 'package:flutter/material.dart';
import 'package:mpibrasil/constants.dart';
import 'package:mpibrasil/generated/l10n.dart';

class License extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(S.current.appTitle),
        titleSpacing: 0.0,
        elevation: 0,
      ),
      body: Column(
        children: <Widget>[
          Container(
            color: kColorMPIGreen,
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Text(
                  S.current.licensePageTitle,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                  textScaleFactor: 1.5,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
