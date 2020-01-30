import 'package:flutter/material.dart';
import 'screens/glossario.dart';
import 'screens/home.dart';
import 'screens/login.dart';
import 'screens/medicamentos.dart';
import 'screens/settings.dart';
import 'screens/test.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: '/',
      routes: <String,WidgetBuilder> {
        '/'             : (context) => TestPage(),
        '/login'        : (context) => Login(),
        '/home'         : (context) => HomePage(),
        '/glossario'    : (context) => Glossario(),
        '/medicamentos' : (context) => Medicamentos(),
        '/settings'     : (context) => Settings(),
      },
    );
  }
}