import 'package:flutter/material.dart';

class AppDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          DrawerHeader(
            child: Text(
              'MPI Brasil',
              style: TextStyle(color: Colors.white),
            ),
            decoration: BoxDecoration(
              color: Colors.green,
            ),
          ),
          ListTile(
            leading: Icon(
              Icons.tag_faces,
            ),
            title: Text('Login'),
            onTap: () {
              Navigator.popAndPushNamed(context, '/auth');
            },
          ),
          ListTile(
            leading: Icon(
              Icons.question_answer,
            ),
            title: Text('FAQ'),
            onTap: () {
              Navigator.popAndPushNamed(context, '/faq');
            },
          ),
          ListTile(
            leading: Icon(
              Icons.info,
            ),
            title: Text('Sobre'),
            onTap: () {
              Navigator.popAndPushNamed(context, '/about');
            },
          ),
          ListTile(
            leading: Icon(
              Icons.settings,
            ),
            title: Text('Configurações'),
            onTap: () {
              Navigator.popAndPushNamed(context, '/settings');
            },
          ),
        ],
      ),
    );
  }
}
