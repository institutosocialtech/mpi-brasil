import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_analytics/firebase_analytics.dart';

import 'screens/about.dart';
import 'screens/faq.dart';
import 'screens/favorites.dart';
import 'screens/glossario.dart';
import 'screens/home.dart';
import 'screens/login.dart';
import 'screens/medicamento_info.dart';
import 'screens/medicamentos.dart';
import 'screens/settings.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(); // inicializa Firebase
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  static FirebaseAnalytics analytics = FirebaseAnalytics();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'MPI Brasil',
      theme: ThemeData(
        primaryColor: Colors.green,
        accentColor: Colors.greenAccent,
        fontFamily: 'Nunito',
      ),
      initialRoute: '/',
      routes: <String, WidgetBuilder>{
        '/': (context) => HomePageWrapper(),
        '/about': (context) => About(),
        '/login': (context) => Login(),
        '/favorites': (context) => Favorites(),
        '/faq': (context) => FAQ(),
        '/glossario': (context) => Glossario(),
        '/medicamentos': (context) => Medicamentos(),
        '/med_info': (context) => MedicamentoInfo(),
        '/settings': (context) => Settings(),
      },
    );
  }
}

/// wrapper para medir tempo de inicio da homepage (semi funcional)
class HomePageWrapper extends StatefulWidget {
  @override
  _HomePageWrapperState createState() => _HomePageWrapperState();
}

class _HomePageWrapperState extends State<HomePageWrapper> {
  Stopwatch _stopwatch = Stopwatch()..start();

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance?.addPostFrameCallback((_) async {
      _stopwatch.stop();
      await MyApp.analytics.logEvent(
        name: 'home_load_time',
        parameters: {'milliseconds': _stopwatch.elapsedMilliseconds},
      );
      print('Home load time: ${_stopwatch.elapsedMilliseconds}ms'); // debug
    });
  }

  @override
  Widget build(BuildContext context) {
    return HomePage();
  }
}
