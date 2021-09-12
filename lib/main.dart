import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'constants.dart';

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
import 'screens/med_details.dart';
import 'screens/onboarding.dart';
import 'screens/privacy_policy_page.dart';
import 'screens/userprofile_settings.dart';
import 'screens/search.dart';
import 'screens/splashscreen.dart';
import 'screens/terms_of_use_page.dart';
import 'screens/userprofile_overview.dart';

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
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            primaryColor: kColorMPIGreen,
            accentColor: kColorMPIWhite,
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
            '/faq': (context) => FAQPage(),
            '/favorites_overview': (context) => FavoritesOverview(),
            '/forgot_password': (context) => ForgotPassword(),
            '/keyword_details': (context) => KeywordDetails(),
            '/keywords_overview': (context) => KeywordsOverview(),
            '/med_details': (context) => MedDetails(),
            '/onboarding': (context) => OnboardingScreen(),
            '/privacy_policy': (context) => PrivacyPolicyPage(),
            '/profile': (context) => ProfileSettings(),
            '/profile_setup': (context) => UserProfileOverview(),
            '/search': (context) => SearchPage(),
            '/tos': (context) => TermsOfUsePage(),
          },
        ),
      ),
    );
  }
}
