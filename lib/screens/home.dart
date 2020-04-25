import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/keywords.dart';
import '../screens/inicio.dart';
import '../screens/favorites.dart';
import '../screens/glossario.dart';
import '../screens/medicamentos.dart';
import '../widgets/drawer.dart';

class HomePage extends StatefulWidget {

  @override
  State<StatefulWidget> createState(){
    return _HomeState();
  }
}

class _HomeState extends State<HomePage> {
  int _currentIndex = 0;

  final List<Widget> _children = [
    Inicio(),
    Medicamentos(),
    ChangeNotifierProvider(create: (ctx) => Keywords(), child: Glossario()),
    Favorites(),
  ];

  @override
  Widget build(BuildContext context) {

    return Scaffold(
        appBar: AppBar(
          title: Text('MPI Brasil'),
          titleSpacing: 0.0,
          elevation: 0,
        ),
        body: _children[_currentIndex],
        drawer: AppDrawer(),
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: _currentIndex,
          elevation: 5,
          type: BottomNavigationBarType.fixed,
          backgroundColor: Colors.white70,
          selectedItemColor: Colors.black,
          unselectedItemColor: Colors.black38,
          showSelectedLabels: false,
          showUnselectedLabels: false,
          onTap: onTabTapped,
          items: [
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              title: Text("Home"),
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.local_hospital),
              title: Text("Medicamentos"),
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.local_library),
              title: Text("Glossário"),
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.star),
              title: Text("Favoritos"),
            ),
          ],
        ),
    );
  }

  void onTabTapped(int index){
    setState(() {
      _currentIndex = index;
    });
  }
}