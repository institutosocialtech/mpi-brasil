import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'providers/auth.dart';
import 'providers/drugs.dart';
import 'providers/keywords.dart';

import 'screens/about.dart';
import 'screens/auth_screen.dart';
import 'screens/faq.dart';
import 'screens/favorites.dart';
import 'screens/glossario.dart';
import 'screens/glossario_info.dart';
import 'screens/home.dart';
import 'screens/medicamento_info.dart';
import 'screens/medicamentos.dart';
import 'screens/settings.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(value: Auth()),
        ChangeNotifierProvider.value(value: Drugs()),
        ChangeNotifierProvider.value(value: Keywords()),
      ],
      child: MaterialApp(
        title: 'MPI Brasil',
        theme: ThemeData(
          primaryColor: Colors.green,
          accentColor: Colors.black,
          fontFamily: 'Nunito',
        ),
        initialRoute: '/auth',
        routes: <String, WidgetBuilder>{
          '/': (context) => HomePage(),
          '/about': (context) => About(),
          '/auth': (context) => AuthScreen(),
          '/favorites': (context) => Favorites(),
          '/faq': (context) => FAQ(),
          '/glossario': (context) => Glossario(),
          '/glossario_info': (context) => GlossarioInfo(),
          '/medicamentos': (context) => Medicamentos(),
          '/med_info': (context) => MedicamentoInfo(),
          '/settings': (context) => Settings(),
        },
      ),
    );
  }
}
