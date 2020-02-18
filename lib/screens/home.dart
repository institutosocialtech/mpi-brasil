import 'package:flutter/material.dart';
import 'medicamentos.dart';
import 'favorites.dart';
import 'glossario.dart';
import 'settings.dart';

class HomePage extends StatefulWidget {

  @override
  State<StatefulWidget> createState(){
    return _HomeState();
  }
}

class _HomeState extends State<HomePage> {
  int _currentIndex = 0;

  final List<Widget> _children = [
    Medicamentos(),
    Favorites(),
    Glossario(),
    Settings(),
  ];

  @override
  Widget build(BuildContext context) {

    return Scaffold(
        appBar: AppBar(
          title: Text('MPI Brasil'),
          titleSpacing: 0.0,
          leading: IconButton(
            icon: Icon(Icons.menu),
            onPressed: () {},
          )
        ),
        body: _children[_currentIndex],
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
              icon: Icon(Icons.star),
              title: Text("Favoritos"),
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.local_library),
              title: Text("Glossário"),
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.settings),
              title: Text("Configurações"),
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