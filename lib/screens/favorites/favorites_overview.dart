import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:mpibrasil/assets.dart';
import 'package:mpibrasil/constants.dart';
import 'package:mpibrasil/generated/l10n.dart';
import 'package:mpibrasil/models/med.dart';
import 'package:mpibrasil/providers/meds_provider.dart';
import 'package:mpibrasil/providers/user_preferences_provider.dart';
import 'package:mpibrasil/screens/search/med_details.dart';

class FavoritesOverview extends StatelessWidget {
  final headerStyle = TextStyle(
    color: Colors.white,
    fontSize: 24,
    fontWeight: FontWeight.bold,
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kColorMPIGreenOpaque,

      // appbar
      appBar: AppBar(
        backgroundColor: kColorMPIGreen,

        // page appbar
        flexibleSpace: Container(
          child: Image.asset(
            MpiAssets.imgMedComposition,
            color: Colors.white.withOpacity(0.15),
            colorBlendMode: BlendMode.multiply,
            fit: BoxFit.cover,
          ),
        ),

        // page title
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(80),
          child: Container(
            alignment: Alignment.centerLeft,
            padding: EdgeInsets.only(left: 20.0, bottom: 40),
            child: Text(S.current.favoritesPageTitle, style: headerStyle),
          ),
        ),
      ),

      // page content
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
        decoration: BoxDecoration(
          color: kColorMPIWhite,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(15.0),
            topRight: Radius.circular(15.0),
          ),
        ),
        child: Column(
          children: [
            Expanded(
              child: FavoriteList(),
            ),
          ],
        ),
      ),
    );
  }
}

class FavoriteList extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final medList = ref.watch(medsNotifierProvider).valueOrNull ?? [];
    final userPreferences = ref.watch(userPreferencesNotifierProvider);

    List<Med> favorites = [];
    for (Med med in medList) {
      if (userPreferences.favorites?.containsKey(med.id) ?? false) {
        favorites.add(med);
      }
    }

    return favorites.isEmpty
        // draw empty favorites message
        ? Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                SvgPicture.asset(MpiAssets.svgUndrawDoctors, width: 192),
                Text(S.current.favoritesEmptyList),
              ],
            ),
          )

        // draw favorites list
        : ListView.separated(
            itemCount: favorites.length,
            separatorBuilder: (BuildContext context, int index) =>
                Divider(color: Colors.transparent),
            itemBuilder: (BuildContext context, int index) {
              var med = favorites[index];

              return Card(
                color: kColorMPIGreenOpaque,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(kCardBorderRadius),
                ),
                child: ListTile(
                  // card layout
                  contentPadding: EdgeInsets.symmetric(
                    horizontal: 20.0,
                    vertical: 10.0,
                  ),

                  // med title
                  title: Text(
                    med.name,
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  // med info
                  subtitle: Text(
                    med.medTypesToString(),
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.normal,
                    ),
                  ),

                  // trailing iconbutton
                  trailing: IconButton(
                    icon: Icon(Icons.star),
                    color: Colors.white,
                    onPressed: () {
                      ref.read(userPreferencesNotifierProvider.notifier).toggleFavorite(med.id);
                      final snackbar = SnackBar(
                        content: Text(S.current.favoriteMedRemoved(med.name)),
                        action: SnackBarAction(
                          label: S.current.undo,
                          textColor: Colors.white,
                          onPressed: () => ref.read(userPreferencesNotifierProvider.notifier).toggleFavorite(med.id),
                        ),
                      );
                      ScaffoldMessenger.of(context).showSnackBar(snackbar);
                    },
                  ),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => MedDetails(med: med),
                      ),
                    );
                  },
                ),
              );
            },
          );
  }
}
