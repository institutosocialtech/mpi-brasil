import 'package:flutter/material.dart';
import 'screens/about.dart';
import 'screens/faq.dart';
import 'screens/favorites.dart';
import 'screens/glossario.dart';
import 'screens/glossario_info.dart';
import 'screens/home.dart';
import 'screens/login.dart';
import 'screens/medicamento_info.dart';
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
        accentColor: Colors.black,
        fontFamily: 'Nunito',
      ),
      initialRoute: '/',
      routes: <String,WidgetBuilder> {
        '/'               : (context) => HomePage(),
        '/about'          : (context) => About(),
        '/login'          : (context) => Login(),
        '/favorites'      : (context) => Favorites(),
        '/faq'            : (context) => FAQ(),
        '/glossario'      : (context) => Glossario(),
        '/glossario_info' : (context) => GlossarioInfo(),
        '/medicamentos'   : (context) => Medicamentos(),
        '/med_info'       : (context) => MedicamentoInfo(),
        '/settings'       : (context) => Settings(),
      },
    );
  }
}