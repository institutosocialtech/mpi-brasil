import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// app theme
import 'theme.dart';

// app translations
import 'generated/l10n.dart';

// app providers
import 'providers/auth_provider.dart';
import 'providers/auth_state.dart';

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

void main() => runApp(const ProviderScope(child: MyApp()));

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  static final _navigatorKey = GlobalKey<NavigatorState>();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // TODO: refactor with go_router — this listener is a patch on the
    // imperative Navigator model (popAndPushNamed / pushReplacementNamed
    // across the app destroys the `/` route, so home: can't react to auth
    // state on its own). A go_router redirect would replace this entirely.
    ref.listen<AsyncValue<AuthState>>(authNotifierProvider, (prev, next) {
      final prevAuth = prev?.valueOrNull;
      final nextAuth = next.valueOrNull;
      final nav = _navigatorKey.currentState;
      if (nav == null) return;
      if (prevAuth is Authenticated && nextAuth is Unauthenticated) {
        nav.pushNamedAndRemoveUntil('/auth', (_) => false);
      } else if (prevAuth is Unauthenticated && nextAuth is Authenticated) {
        nav.pushNamedAndRemoveUntil('/', (_) => false);
      }
    });

    final authAsync = ref.watch(authNotifierProvider);

    return MaterialApp(
      navigatorKey: _navigatorKey,
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
      home: authAsync.when(
        loading: () => SplashScreen(),
        error: (_, __) => LoginPage(),
        data: (authState) {
          if (authState is Authenticated) {
            return LoadingScreen();
          }
          return LoginPage();
        },
      ),
      routes: <String, WidgetBuilder>{
        '/about': (context) => AboutPage(),
        '/auth': (context) => LoginPage(),
        '/desprescribing': (context) => DesprescribingPage(),
        '/faq': (context) => FAQPage(),
        '/favorites_overview': (context) => FavoritesOverview(),
        '/forgot_password': (context) => ForgotPassword(),
        '/keywords_overview': (context) => KeywordsOverview(),
        '/onboarding': (context) => OnboardingScreen(),
        '/privacy_policy': (context) => PrivacyPolicyPage(),
        '/profile': (context) => ProfileSettings(),
        '/profile_setup': (context) => UserProfileOverview(),
        '/delete_account': (context) => DeleteAccount(),
        '/search': (context) => SearchPage(),
        '/signup': (context) => SignUpPage(),
        '/tos': (context) => TermsOfUsePage(),
      },
    );
  }
}
