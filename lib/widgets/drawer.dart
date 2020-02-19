import 'package:flutter/material.dart';

class AppDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              child: Text('MPI Brasil', style: TextStyle(color: Colors.white),),
              decoration: BoxDecoration(
                color: Colors.green,
              ),
            ),
            ListTile(
              title: Text('Login'),
              onTap: () {
                Navigator.popAndPushNamed(context, '/login');
              },
            ),
            ListTile(
              title: Text('FAQ'),
              onTap: () {
                Navigator.popAndPushNamed(context, '/faq');
              },
            ),
            ListTile(
              title: Text('Sobre'),
              onTap: () {
                Navigator.popAndPushNamed(context, '/about');
              },
            ),
          ],
        ),
      );
  }
}