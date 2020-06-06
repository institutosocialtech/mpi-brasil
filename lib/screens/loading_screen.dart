import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoadingScreen extends StatefulWidget {
  @override
  _LoadingScreenState createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  Future _checkFirstBoot() async {
    final appPrefs = await SharedPreferences.getInstance();
    bool _firstBoot = (appPrefs.getBool('firstBoot') ?? true);

    if (_firstBoot) {
      print("first boot!");
      await appPrefs.setBool('firstBoot', false);
      Navigator.pushReplacementNamed(context, '/onboarding');
    } else {
      Navigator.pushReplacementNamed(context, '/search');
    }
  }

  @override
  void initState() {
    super.initState();
    _checkFirstBoot();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Colors.green[900],
            Colors.green[200],
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          stops: [0, 1],
        ),
      ),
    );
  }
}
