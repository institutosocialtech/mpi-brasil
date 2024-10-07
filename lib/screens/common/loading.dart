import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:mpibrasil/providers/userpreferences.dart';
import 'package:mpibrasil/screens/common/splashscreen.dart';
import 'package:provider/provider.dart';

class LoadingScreen extends StatefulWidget {
  @override
  _LoadingScreenState createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  final _secureStorage = FlutterSecureStorage();

  Future _checkFirstBoot() async {
    final firstBootString =
        await _secureStorage.read(key: 'firstBoot') ?? "true";
    final isFirstBoot = bool.parse(firstBootString);

    var userPreferences = Provider.of<UserPreferences>(context, listen: false);
    await userPreferences.fetchUserData();

    if (!userPreferences.user.isProfileComplete) {
      await _secureStorage.write(key: 'firstBoot', value: "false");
      Navigator.pushReplacementNamed(context, '/profile_setup');
    } else if (isFirstBoot) {
      await _secureStorage.write(key: 'firstBoot', value: "false");
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
