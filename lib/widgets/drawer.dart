import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:provider/provider.dart';
import '../providers/auth.dart';

class AppDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          DrawerHeader(
            child: Image.asset(
              "assets/images/logo.png",
              fit: BoxFit.fitHeight,
            ),
            decoration: BoxDecoration(
              color: Colors.white,
            ),
          ),
          ListTile(
            leading: Icon(AntDesign.search1),
            title: Text('Buscar'),
            onTap: () {
              // close drawer
              Navigator.pop(context);
            },
          ),
          ListTile(
            leading: Icon(AntDesign.staro),
            title: Text('Favoritos'),
            onTap: () {
              Navigator.popAndPushNamed(context, '/favorites_overview');
            },
          ),
          ListTile(
            leading: Icon(AntDesign.medicinebox),
            title: Text('Medicamentos'),
            onTap: () {
              Navigator.popAndPushNamed(context, '/meds_overview');
            },
          ),
          ListTile(
            leading: Icon(AntDesign.book),
            title: Text('Glossário'),
            onTap: () {
              Navigator.popAndPushNamed(context, '/keywords_overview');
            },
          ),
          ListTile(
            leading: Icon(AntDesign.infocirlceo),
            title: Text('Sobre'),
            onTap: () {
              Navigator.popAndPushNamed(context, '/about');
            },
          ),
          ListTile(
            leading: Icon(AntDesign.question),
            title: Text('FAQ'),
            onTap: () {
              Navigator.popAndPushNamed(context, '/faq');
            },
          ),
          ListTile(
            leading: Icon(AntDesign.logout),
            title: Text('Sair'),
            onTap: () {
              Navigator.pop(context);
              Navigator.pushReplacementNamed(context, '/');
              Provider.of<Auth>(context, listen: false).logout();
            },
          ),
        ],
      ),
    );
  }
}
