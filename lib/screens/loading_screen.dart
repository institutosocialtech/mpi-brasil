import 'dart:async';
import 'package:flutter/material.dart';
import 'package:mpibrasil/screens/splashscreen.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../providers/userpreferences.dart';

class LoadingScreen extends StatefulWidget {
  @override
  _LoadingScreenState createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  Future _checkFirstBoot() async {
    final appPrefs = await SharedPreferences.getInstance();
    bool _firstBoot = (appPrefs.getBool('firstBoot') ?? true);

    var userPreferences = Provider.of<UserPreferences>(context, listen: false);
    await userPreferences.fetchUserData();

    if (userPreferences.user.name == null) {
      print('loading profile setup...');
      await appPrefs.setBool('firstBoot', false);
      Navigator.pushReplacementNamed(context, '/profile_setup');
    } else if (_firstBoot) {
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
    return SplashScreen();
  }
}
