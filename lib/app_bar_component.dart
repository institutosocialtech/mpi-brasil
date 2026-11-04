import 'package:flutter/material.dart';
import 'package:mpibrasil/assets.dart';
import 'package:mpibrasil/constants.dart';

  class AppBarSec extends StatelessWidget {
  final Widget child;

  // Construtor correto
  const AppBarSec({
    super.key, 
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
        backgroundColor: kColorMPIGreen, //kColorMPIGreen, //kColorMPIGreenOpaque
      
        // page appbar
        flexibleSpace: Container(
          child: Image.asset(
            MpiAssets.imgMedComposition,
            color: Colors.white.withOpacity(0.15),
            colorBlendMode: BlendMode.multiply,
            fit: BoxFit.cover,
          ),
        ),

        // page title
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(80),
          child: Container(
            alignment: Alignment.centerLeft,
            padding: EdgeInsets.only(left: 20.0, bottom: 40),
            child: child,
          ),
        ),
      );
  }
 
}
