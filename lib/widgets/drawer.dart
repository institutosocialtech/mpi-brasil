import 'package:flutter/material.dart';

class AppDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          DrawerHeader(
            child: Image.asset(
              "assets/images/logo.jpg",
              fit: BoxFit.fitHeight,
            ),
            decoration: BoxDecoration(
              color: Colors.white,
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
