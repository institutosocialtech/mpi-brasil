import 'package:flutter/material.dart';
import 'package:mpibrasil/screens/profile/delete_account.dart';
import 'package:provider/provider.dart';

import 'theme.dart';

import 'providers/auth.dart';
import 'providers/keywords.dart';
import 'providers/meds.dart';
import 'providers/userpreferences.dart';

import 'screens/about/about_page.dart';
import 'screens/login/login_page.dart';
import 'screens/about/faq_page.dart';
import 'screens/favorites/favorites_overview.dart';
import 'screens/login/forgot_password.dart';
import 'screens/common/loading.dart';
import 'screens/keywords/keywords_overview.dart';
import 'screens/keywords/keyword_details.dart';
import 'screens/search/med_details.dart';
import 'screens/onboarding/onboarding.dart';
import 'screens/about/privacy_page.dart';
import 'screens/profile/userprofile_settings.dart';
import 'screens/search/search_page.dart';
import 'screens/login/signup_page.dart';
import 'screens/common/splashscreen.dart';
import 'screens/about/tos_page.dart';
import 'screens/profile/userprofile_overview.dart';

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
          theme: appTheme,
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
            '/delete_account': (context) => DeleteAccount(),
            '/search': (context) => SearchPage(),
            '/signup': (context) => SignUpPage(),
            '/tos': (context) => TermsOfUsePage(),
          },
        ),
      ),
    );
  }
}
