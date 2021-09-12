import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_svg/svg.dart';

import '../constants.dart';
import '../models/med.dart';
import '../providers/meds.dart';
import '../providers/userpreferences.dart';
import '../screens/med_details.dart';

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
            'assets/images/med_composition.png',
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
            child: Text('FAVORITOS', style: headerStyle),
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
        child: Expanded(
          child: FavoriteList(),
        ),
      ),
    );
  }
}

class FavoriteList extends StatefulWidget {
  @override
  _FavoriteListState createState() => _FavoriteListState();
}

class _FavoriteListState extends State<FavoriteList> {
  @override
  Widget build(BuildContext context) {
    List<Med> _favorites = [];
    final medList = Provider.of<Meds>(context, listen: false).meds;
    final userPreferences = Provider.of<UserPreferences>(context, listen: true);

    for (Med med in medList) {
      if (userPreferences.isFavorite(med.id)) {
        _favorites.add(med);
      }
    }

    return _favorites.isEmpty
        // draw empty favorites message
        ? Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                SvgPicture.asset("assets/undraw_svg/doctors.svg", width: 192),
                Text("Você não possui nenhum medicamento favorito."),
              ],
            ),
          )

        // draw favorites list
        : ListView.separated(
            itemCount: _favorites.length,
            separatorBuilder: (BuildContext context, int index) =>
                Divider(color: Colors.transparent),
            itemBuilder: (BuildContext context, int index) {
              var med = _favorites[index];

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
                      userPreferences.toggleFavorite(med.id);
                      final snackbar = SnackBar(
                        content: Text('"${med.name}" removido dos favoritos.'),
                        action: SnackBarAction(
                          label: 'Desfazer',
                          textColor: Colors.white,
                          onPressed: () {
                            userPreferences.toggleFavorite(med.id);
                          },
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
