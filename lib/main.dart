import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'providers/auth.dart';
import 'providers/keywords.dart';
import 'providers/meds.dart';
import 'providers/userpreferences.dart';

import 'screens/about.dart';
import 'screens/login.dart';
import 'screens/faq.dart';
import 'screens/favorites_overview.dart';
import 'screens/forgot_password.dart';
import 'screens/loading_screen.dart';
import 'screens/keywords_overview.dart';
import 'screens/keyword_details.dart';
import 'screens/home.dart';
import 'screens/med_details.dart';
import 'screens/meds_overview.dart';
import 'screens/onboarding.dart';
import 'screens/search.dart';
import 'screens/splashscreen.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(
          value: Auth(),
        ),
        ChangeNotifierProxyProvider<Auth, UserPreferences>(
          create: null,
          update: (context, auth, previous) => UserPreferences(
            auth.token,
            auth.userId,
            previous == null ? null : previous.user,
          ),
        ),
        ChangeNotifierProxyProvider<Auth, Meds>(
          create: null,
          update: (context, auth, previous) => Meds(
            auth.token,
            previous == null ? [] : previous.meds,
          ),
        ),
        ChangeNotifierProxyProvider<Auth, Keywords>(
          create: null,
          update: (context, auth, previous) => Keywords(
            auth.token,
            previous == null ? [] : previous.keywords,
          ),
        ),
      ],
      child: Consumer<Auth>(
        builder: (context, auth, _) => MaterialApp(
          title: 'MPI Brasil',
          theme: ThemeData(
            primaryColor: Colors.green,
            accentColor: Colors.black,
            fontFamily: 'Nunito',
          ),
          home: auth.isAuth
              ? LoadingScreen()
              : FutureBuilder(
                  future: auth.tryAutoLogin(),
                  builder: (context, authResult) =>
                      authResult.connectionState == ConnectionState.waiting
                          ? SplashScreen()
                          : LoginPage(),
                ),
          routes: <String, WidgetBuilder>{
            '/about': (context) => AboutPage(),
            '/auth': (context) => LoginPage(),
            '/forgot_password': (context) => ForgotPassword(),
            '/favorites_overview': (context) => FavoritesOverview(),
            '/faq': (context) => FAQPage(),
            '/keywords_overview': (context) => KeywordsOverview(),
            '/keyword_details': (context) => KeywordDetails(),
            '/home': (context) => HomePage(),
            '/search': (context) => SearchPage(),
            '/meds_overview': (context) => MedsOverview(),
            '/med_details': (context) => MedDetails(),
            '/onboarding': (context) => OnboardingScreen(),
          },
        ),
      ),
    );
  }
}
