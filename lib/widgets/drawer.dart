import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:mpibrasil/assets.dart';
import 'package:mpibrasil/constants.dart';
import 'package:mpibrasil/generated/l10n.dart';
import 'package:mpibrasil/providers/auth.dart';
import 'package:mpibrasil/providers/userpreferences.dart';
import 'package:provider/provider.dart';

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
          title: Text(S.current.logoutDialogTitle, style: headerStyle),
          content: Text(S.current.logoutDialogContent, style: messageStyle),
          actionsPadding: EdgeInsets.all(4.0),
          actions: <Widget>[
            TextButton(
              onPressed: () => Navigator.of(context).pop(false),
              child: Text(S.current.no),
              style: TextButton.styleFrom(
                foregroundColor: kColorMPIGray,
                backgroundColor: kColorMPIWhite,
              ),
            ),
            TextButton(
              onPressed: () => Navigator.of(context).pop(true),
              child: Text(S.current.yes),
              style: TextButton.styleFrom(
                foregroundColor: Colors.white,
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

            // logout button
            ListTile(
              leading: Icon(Icons.exit_to_app, color: kColorMPIGray),
              onTap: () => _logout(context),
              title: Text(
                S.current.logout,
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
      child: Container(
        child: SvgPicture.asset(
          MpiAssets.svgGroup3,
          fit: BoxFit.contain,
          color: kColorMPIGreen,
        ),
      ),
    );
  }

  Widget _buildUserTile(BuildContext context) {
    var _userPrefs = Provider.of<UserPreferences>(context, listen: false);
    var _userName = _userPrefs.user.name ?? '';

    var _userStyle = TextStyle(
      color: kColorMPIGray,
      fontSize: 12,
    );

    return ListTile(
      title: Text(S.current.drawerGreeting(_userName), style: _userStyle),
      onTap: () => Navigator.of(context).popAndPushNamed('/profile'),
    );
  }

  Widget _buildDrawerList(BuildContext context) {
    var labelStyle = TextStyle(
      color: kColorMPIGray,
      fontSize: 12,
    );

    return Column(
      children: <Widget>[
        ListTile(
          leading: Icon(Icons.search, color: kColorMPIGray),
          title: Text(S.current.drawerSearch, style: labelStyle),
          onTap: () => Navigator.pop(context),
        ),
        ListTile(
          leading: Icon(Icons.star_outline, color: kColorMPIGray),
          title: Text(S.current.drawerFavorites, style: labelStyle),
          onTap: () =>
              Navigator.popAndPushNamed(context, '/favorites_overview'),
        ),
        ListTile(
          leading: Icon(Icons.book, color: kColorMPIGray),
          title: Text(S.current.drawerKeywords, style: labelStyle),
          onTap: () => Navigator.popAndPushNamed(context, '/keywords_overview'),
        ),
        ListTile(
          leading: Icon(Icons.question_mark, color: kColorMPIGray),
          title: Text(S.current.drawerFAQ, style: labelStyle),
          onTap: () => Navigator.popAndPushNamed(context, '/faq'),
        ),
        ListTile(
          leading: Icon(Icons.info, color: kColorMPIGray),
          title: Text(S.current.drawerAbout, style: labelStyle),
          onTap: () => Navigator.popAndPushNamed(context, '/about'),
        ),
      ],
    );
  }
}
