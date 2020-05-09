import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';

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
                AntDesign.search1
            ),
            title: Text('Buscar'),
            onTap: () {
              Navigator.popAndPushNamed(context, '/search');
            },
          ),

          ListTile(
            leading: Icon(
                AntDesign.medicinebox
            ),
            title: Text('Medicamentos'),
            onTap: () {
              Navigator.popAndPushNamed(context, '/meds_overview');
            },
          ),
          ListTile(
            leading: Icon(
              AntDesign.book,
            ),
            title: Text('Glossário'),
            onTap: () {
              Navigator.popAndPushNamed(context, '/keywords_overview');
            },
          ),
          ListTile(
            leading: Icon(
              MaterialIcons.favorite_border,
            ),
            title: Text('Favoritos'),
            onTap: () {
              Navigator.popAndPushNamed(context, '/favorites_overview');
            },
          ),
          ListTile(
            leading: Icon(
              SimpleLineIcons.question,
            ),
            title: Text('FAQ'),
            onTap: () {
              Navigator.popAndPushNamed(context, '/faq');
            },
          ),
          ListTile(
            leading: Icon(
              SimpleLineIcons.info,
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
