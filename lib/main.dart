import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';

// app theme
import 'theme.dart';

// app translations
import 'generated/l10n.dart';

// app models
import 'models/user.dart';

// app providers
import 'providers/auth.dart';
import 'providers/keywords.dart';
import 'providers/meds.dart';
import 'providers/userpreferences.dart';

// app screens
import 'screens/about/about_page.dart';
import 'screens/about/faq_page.dart';
import 'screens/about/privacy_page.dart';
import 'screens/about/tos_page.dart';
import 'screens/common/loading.dart';
import 'screens/common/splashscreen.dart';
import 'screens/desprescribing/desprescribing_page.dart';
import 'screens/favorites/favorites_overview.dart';
import 'screens/keywords/keywords_overview.dart';
import 'screens/login/forgot_password.dart';
import 'screens/login/login_page.dart';
import 'screens/login/signup_page.dart';
import 'screens/onboarding/onboarding.dart';
import 'screens/profile/delete_account.dart';
import 'screens/profile/userprofile_settings.dart';
import 'screens/profile/userprofile_overview.dart';
import 'screens/search/search_page.dart';

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
          create: (_) => UserPreferences('', '', User(id: '')),
          update: (context, auth, previous) => UserPreferences(
            auth.token ?? '',
            auth.userId ?? '',
            previous == null ? User(id: '') : previous.user,
          ),
        ),
        ChangeNotifierProxyProvider<Auth, Meds>(
          create: (_) => Meds('', []),
          update: (context, auth, previous) => Meds(
            auth.token ?? '',
            previous == null ? [] : previous.meds,
          ),
        ),
        ChangeNotifierProxyProvider<Auth, Keywords>(
          create: (_) => Keywords('', []),
          update: (context, auth, previous) => Keywords(
            auth.token ?? '',
            previous == null ? [] : previous.keywords,
          ),
        ),
      ],
      child: Consumer<Auth>(
        builder: (context, auth, _) => MaterialApp(
          title: "MPI Brasil",
          debugShowCheckedModeBanner: false,
          localizationsDelegates: [
            S.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          supportedLocales: S.delegate.supportedLocales,
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
            '/desprescribing': (context) => DesprescribingPage(),
            '/faq': (context) => FAQPage(),
            '/favorites_overview': (context) => FavoritesOverview(),
            '/forgot_password': (context) => ForgotPassword(),
            // '/keyword_details': (context) => KeywordDetails(),
            '/keywords_overview': (context) => KeywordsOverview(),
            // '/med_details': (context) => MedDetails(),
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
