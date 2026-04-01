import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:material_symbols_icons/symbols.dart';
import 'package:mpibrasil/assets.dart';
import 'package:mpibrasil/constants.dart';
import 'package:mpibrasil/generated/l10n.dart';
import 'package:mpibrasil/providers/auth_provider.dart';
import 'package:mpibrasil/providers/user_preferences_provider.dart';

class AppDrawer extends ConsumerWidget {
  final tileLabelStyle = TextStyle(
    color: kColorMPIGray,
    fontSize: 14,
    fontWeight: FontWeight.bold,
  );

  Future<void> _logout(BuildContext context, WidgetRef ref) async {
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
      await ref.read(authNotifierProvider.notifier).logout();
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
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
            _buildUserTile(context, ref),

            // nav buttons
            Divider(indent: 20, endIndent: 20),
            _buildDrawerList(context),
            Divider(indent: 20, endIndent: 20),

            // use expanded as spacer to move the logout button to the bottom.
            Expanded(child: Container()),

            // logout button
            ListTile(
              leading: Icon(Icons.exit_to_app, color: kColorMPIGray),
              title: Text(S.current.logout),
              titleTextStyle: tileLabelStyle,
              onTap: () => _logout(context, ref),
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

  Widget _buildUserTile(BuildContext context, WidgetRef ref) {
    final user = ref.watch(userPreferencesNotifierProvider);
    final userName = user.name ?? '';

    return ListTile(
      dense: true,
      title: Text(S.current.drawerGreeting(userName)),
      titleTextStyle: tileLabelStyle,
      trailing: Icon(Symbols.settings_account_box, color: kColorMPIGray),
      onTap: () => Navigator.of(context).popAndPushNamed('/profile'),
    );
  }

  Widget _buildDrawerList(BuildContext context) {
    return Column(
      children: <Widget>[
        ListTile(
          leading: Icon(Symbols.search, color: kColorMPIGreen),
          title: Text(S.current.drawerSearch),
          titleTextStyle: tileLabelStyle,
          onTap: () => Navigator.pop(context),
        ),
        ListTile(
          leading: Icon(Symbols.clinical_notes, color: kColorMPIGreen),
          title: Text(S.current.drawerDesprescribing),
          titleTextStyle: tileLabelStyle,
          onTap: () => Navigator.popAndPushNamed(context, '/desprescribing'),
        ),
        ListTile(
          leading: Icon(Symbols.star_outline, color: kColorMPIGreen),
          title: Text(S.current.drawerFavorites),
          titleTextStyle: tileLabelStyle,
          onTap: () =>
              Navigator.popAndPushNamed(context, '/favorites_overview'),
        ),
        ListTile(
          leading: Icon(Symbols.book, color: kColorMPIGreen),
          title: Text(S.current.drawerKeywords),
          titleTextStyle: tileLabelStyle,
          onTap: () => Navigator.popAndPushNamed(context, '/keywords_overview'),
        ),
        ListTile(
          leading: Icon(Symbols.question_mark, color: kColorMPIGreen),
          title: Text(S.current.drawerFAQ),
          titleTextStyle: tileLabelStyle,
          onTap: () => Navigator.popAndPushNamed(context, '/faq'),
        ),
        ListTile(
          leading: Icon(Symbols.info, color: kColorMPIGreen),
          title: Text(S.current.drawerAbout),
          titleTextStyle: tileLabelStyle,
          onTap: () => Navigator.popAndPushNamed(context, '/about'),
        ),
      ],
    );
  }
}
