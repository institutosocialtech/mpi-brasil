import 'package:flutter/material.dart';
import 'package:mpibrasil/screens/search.dart';
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
import 'screens/settings.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(value: Auth()),
        ChangeNotifierProvider.value(value: Meds()),
        ChangeNotifierProvider.value(value: Keywords()),
      ],
      child: Consumer<Auth>(
        builder: (context, auth, _) => MaterialApp(
          title: 'MPI Brasil',
          theme: ThemeData(
            primaryColor: Colors.green,
            accentColor: Colors.black,
            fontFamily: 'Nunito',
          ),
          // home: auth.isAuth ? HomePage() : AuthScreen(),
          home: HomePage(),
          routes: <String, WidgetBuilder>{
            '/about': (context) => AboutPage(),
            '/auth': (context) => LoginPage(),
            '/favorites_overview': (context) => FavoritesOverview(),
            '/faq': (context) => FAQPage(),
            '/keywords_overview': (context) => KeywordsOverview(),
            '/keyword_details': (context) => KeywordDetails(),
            '/home': (context) => HomePage(),
            '/search': (context) => SearchPage(),
            '/meds_overview': (context) => MedsOverview(),
            '/med_details': (context) => MedDetails(),
            '/settings': (context) => SettingsPage(),
          },
        ),
      ),
    );
  }
}
