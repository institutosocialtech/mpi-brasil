import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:provider/provider.dart';
import '../providers/auth.dart';
import '../providers/userpreferences.dart';

class AppDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          _buildDrawerHeader(context),
          _buildUserTile(context),
          Divider(),
          _buildDrawerList(context),
        ],
      ),
    );
  }

  Widget _buildDrawerHeader(BuildContext context) {
    return DrawerHeader(
      child: Container(),
      decoration: BoxDecoration(
        color: Colors.grey[100],
        image: DecorationImage(
          image: AssetImage('assets/images/logo.png'),
          alignment: Alignment.center,
          fit: BoxFit.fitHeight,
        ),
      ),
    );
  }

  Widget _buildUserTile(BuildContext context) {
    var _userPrefs = Provider.of<UserPreferences>(context, listen: false);
    var _userName = _userPrefs.user.name;

    return ListTile(
      title: Text(_userName),
      onTap: () => Navigator.of(context).popAndPushNamed('/profile'),
      trailing: GestureDetector(
        child: Icon(Icons.exit_to_app),
        onTap: () async {
          final action = await showDialog(
            context: context,
            barrierDismissible: false,
            builder: (BuildContext context) {
              return AlertDialog(
                elevation: 24,
                title: Text('Sair'),
                content: Text('Deseja efetuar o logout?'),
                actions: <Widget>[
                  FlatButton(
                    onPressed: () => Navigator.of(context).pop(false),
                    child: Text('Não'),
                    textColor: Colors.green,
                  ),
                  FlatButton(
                    onPressed: () => Navigator.of(context).pop(true),
                    child: Text('Sim'),
                    textColor: Colors.white,
                    color: Colors.green,
                  ),
                ],
              );
            },
          );

          if (action) {
            Navigator.pop(context);
            Navigator.pushReplacementNamed(context, '/');
            Provider.of<Auth>(context, listen: false).logout();
          }
        },
      ),
    );
  }

  Widget _buildDrawerList(BuildContext context) {
    return Column(
      children: <Widget>[
        ListTile(
          leading: Icon(AntDesign.search1),
          title: Text('Buscar Medicamentos'),
          onTap: () => Navigator.pop(context),
        ),
        ListTile(
          leading: Icon(AntDesign.staro),
          title: Text('Favoritos'),
          onTap: () =>
              Navigator.popAndPushNamed(context, '/favorites_overview'),
        ),
        ListTile(
          leading: Icon(AntDesign.book),
          title: Text('Glossário'),
          onTap: () => Navigator.popAndPushNamed(context, '/keywords_overview'),
        ),
        ListTile(
          leading: Icon(AntDesign.question),
          title: Text('FAQ'),
          onTap: () => Navigator.popAndPushNamed(context, '/faq'),
        ),
        ListTile(
          leading: Icon(AntDesign.infocirlceo),
          title: Text('Sobre'),
          onTap: () => Navigator.popAndPushNamed(context, '/about'),
        ),
      ],
    );
  }
}
