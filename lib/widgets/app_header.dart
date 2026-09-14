// widgets/app_header.dart
import 'package:flutter/material.dart';
import 'package:mpibrasil/assets.dart';
import 'package:mpibrasil/constants.dart';

class AppHeader extends StatelessWidget {
  final String title;
  final double titleFontSize;
  final Widget? leading;
  final List<Widget> actions; 

  const AppHeader({
    super.key,
    required this.title,
    this.titleFontSize = 24,
    this.leading,
    this.actions = const [],
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: kColorMPIGreen,
      leading: leading,
      actions: actions.isNotEmpty ? actions : null,
      flexibleSpace: Container(
        child: Image.asset(
          MpiAssets.imgMedComposition,
          color: Colors.white.withOpacity(0.15),
          colorBlendMode: BlendMode.multiply,
          fit: BoxFit.cover,
        ),
      ),
      bottom: PreferredSize(
        preferredSize: const Size.fromHeight(80),
        child: Container(
          alignment: Alignment.centerLeft,
          padding: const EdgeInsets.only(left: 20.0, bottom: 40),
          child: Text(
            title,
            style: TextStyle(
              color: Colors.white,
              fontSize: titleFontSize,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}