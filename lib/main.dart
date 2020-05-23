import 'package:flutter/material.dart';
import 'package:mpibrasil/screens/forgot_password.dart';
import 'package:provider/provider.dart';

import 'providers/auth.dart';
import 'providers/meds.dart';
import 'providers/keywords.dart';

import 'screens/about.dart';
import 'screens/login.dart';
import 'screens/faq.dart';
import 'screens/favorites_overview.dart';
import 'screens/keywords_overview.dart';
import 'screens/keyword_details.dart';
import 'screens/home.dart';
import 'screens/med_details.dart';
import 'screens/meds_overview.dart';
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
        ChangeNotifierProxyProvider<Auth, Meds>(
          update: (context, auth, previous) => Meds(
            auth.token,
            previous == null ? [] : previous.meds,
          ),
        ),
        ChangeNotifierProxyProvider<Auth, Keywords>(
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
              ? SearchPage()
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
          },
        ),
      ),
    );
  }
}
