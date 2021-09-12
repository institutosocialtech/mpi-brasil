import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:provider/provider.dart';
import '../constants.dart';
import '../providers/auth.dart';
import '../providers/userpreferences.dart';

class AppDrawer extends StatelessWidget {
  void _logout(BuildContext context) async {
    var headerStyle = TextStyle(
      color: kColorMPIGray,
      fontSize: 17,
      fontWeight: FontWeight.bold,
    );

    var messageStyle = TextStyle(
      color: kColorMPIGray,
      fontWeight: FontWeight.normal,
    );

    final action = await showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          elevation: 24,
          title: Text('Sair', style: headerStyle),
          content: Text('Deseja efetuar o logout?', style: messageStyle),
          actionsPadding: EdgeInsets.all(4.0),
          actions: <Widget>[
            TextButton(
              onPressed: () => Navigator.of(context).pop(false),
              child: Text('Não'),
              style: TextButton.styleFrom(
                primary: kColorMPIGray,
                backgroundColor: kColorMPIWhite,
              ),
            ),
            TextButton(
              onPressed: () => Navigator.of(context).pop(true),
              child: Text('Sim'),
              style: TextButton.styleFrom(
                primary: Colors.white,
                backgroundColor: kColorMPIGreen,
              ),
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
  }

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.only(
        topRight: Radius.circular(kDrawerBorderRadius),
        bottomRight: Radius.circular(kDrawerBorderRadius),
      ),
      child: Drawer(
        child: Column(
          children: <Widget>[
            // header logo
            _buildDrawerHeader(context),

            // user info
            _buildUserTile(context),

            // nav buttons
            Divider(indent: 20, endIndent: 20),
            _buildDrawerList(context),
            Divider(indent: 20, endIndent: 20),

            // use expanded as spacer to move the logout button to the bottom.
            Expanded(
              child: Container(),
            ),

            // logout butotn
            ListTile(
              leading: Icon(Icons.exit_to_app, color: kColorMPIGray),
              onTap: () => _logout(context),
              title: Text(
                'Sair',
                style: TextStyle(
                  color: kColorMPIGray,
                  fontSize: 14,
                ),
              ),
            ),
          ],
        ),
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
          fit: BoxFit.cover,
        ),
      ),
    );
  }

  Widget _buildUserTile(BuildContext context) {
    var _userPrefs = Provider.of<UserPreferences>(context, listen: false);
    var _userName = _userPrefs.user.name;

    return ListTile(
      title: Text('Olá, $_userName'),
      onTap: () => Navigator.of(context).popAndPushNamed('/profile'),
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
