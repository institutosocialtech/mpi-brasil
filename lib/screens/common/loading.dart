import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:mpibrasil/providers/user_preferences_provider.dart';
import 'package:mpibrasil/screens/common/splashscreen.dart';

class LoadingScreen extends ConsumerStatefulWidget {
  @override
  ConsumerState<LoadingScreen> createState() => _LoadingScreenState();
}

class _LoadingScreenState extends ConsumerState<LoadingScreen> {
  final _secureStorage = FlutterSecureStorage();

  Future _checkFirstBoot() async {
    final firstBootString =
        await _secureStorage.read(key: 'firstBoot') ?? "true";
    final isFirstBoot = bool.parse(firstBootString);

    await ref.read(userPreferencesNotifierProvider.notifier).fetchUserData();
    final user = ref.read(userPreferencesNotifierProvider);

    if (!user.isProfileComplete) {
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
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _checkFirstBoot();
    });
  }

  @override
  Widget build(BuildContext context) {
    return SplashScreen();
  }
}
