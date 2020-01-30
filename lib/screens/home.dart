import 'package:flutter/material.dart';
import 'medicamentos.dart';
import 'glossario.dart';
import 'info.dart';

class HomePage extends StatefulWidget {

  @override
  State<StatefulWidget> createState(){
    return _HomeState();
  }
}

class _HomeState extends State<HomePage> {
  int _currentIndex = 0;

  final List<Widget> _children = [
    Info(),
    Medicamentos(),
    Glossario(),
  ];

  @override
  Widget build(BuildContext context) {

    return Scaffold(
        appBar: AppBar(
          leading: Padding(
            padding: const EdgeInsets.all(12),
            child: Image.asset(
              'assets/icons/health.png',
              fit: BoxFit.contain
            ),
          ),
          title: Text("MPI Brasil"),
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.person),
              onPressed: () {
                Navigator.pushNamed(context, '/login');
              }
            ),
            IconButton(
              icon: Icon(Icons.settings),
              onPressed: () {
                Navigator.pushNamed(context, '/settings');
               },
            ),
          ],
        ),
        body: _children[_currentIndex],
        bottomNavigationBar: BottomNavigationBar(
          selectedItemColor: Colors.black,
          unselectedItemColor: Colors.black45,
          currentIndex: _currentIndex,
          onTap: onTabTapped,
          items: [
            BottomNavigationBarItem(
              icon: Image.asset('assets/icons/health.png', height: 40),
              title: Text("Home", style: TextStyle(fontSize: 14)),
            ),
            BottomNavigationBarItem(
              icon: Image.asset('assets/icons/drug.png', height: 40),
              title: Text("Medicamentos", style: TextStyle(fontSize: 14)),
            ),
            BottomNavigationBarItem(
              icon: Image.asset('assets/icons/agenda.png', height: 40),
              title: Text("Glossário", style: TextStyle(fontSize: 14)),
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