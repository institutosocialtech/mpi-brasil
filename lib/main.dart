import 'package:flutter/material.dart';
import 'screens/about.dart';
import 'screens/faq.dart';
import 'screens/favorites.dart';
import 'screens/glossario.dart';
import 'screens/home.dart';
import 'screens/login.dart';
import 'screens/medicamentos.dart';
import 'screens/settings.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
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
      routes: <String,WidgetBuilder> {
        '/'             : (context) => HomePage(),
        '/about'        : (context) => About(),
        '/login'        : (context) => Login(),
        '/favorites'    : (context) => Favorites(),
        '/faq'          : (context) => FAQ(),
        '/glossario'    : (context) => Glossario(),
        '/medicamentos' : (context) => Medicamentos(),
        '/settings'     : (context) => Settings(),
      },
    );
  }
}