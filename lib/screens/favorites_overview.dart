import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/med.dart';
import '../providers/meds.dart';
import '../providers/userpreferences.dart';
import '../screens/med_details.dart';

class FavoritesOverview extends StatelessWidget {
  final headerStyle =
      TextStyle(color: Colors.white, fontWeight: FontWeight.bold);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('MPI Brasil'),
        titleSpacing: 0.0,
        elevation: 0,
      ),
      body: Column(
        children: <Widget>[
          Container(
            height: 80,
            color: Colors.green,
            child: Row(
              children: <Widget>[
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                  child: Text("Favoritos".toUpperCase(),
                      textScaleFactor: 1.5, style: headerStyle),
                ),
              ],
            ),
          ),
          Expanded(child: FavoriteList()),
        ],
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
    final medList = Provider.of<Meds>(context).meds;
    final userPreferences = Provider.of<UserPreferences>(context);

    for (Med med in medList) {
      if (userPreferences.isFavorite(med.id)) {
        _favorites.add(med);
      }
    }

    return _favorites.isEmpty
        ? Container(
            color: Colors.white,
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Image.asset("assets/undraw/doctors.png", width: 192),
                  Text(
                    "Você não possui nenhum medicamento favorito.",
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
          )
        : Container(
            child: ListView.separated(
              itemCount: _favorites.length,
              separatorBuilder: (BuildContext context, int index) => Divider(),
              itemBuilder: (BuildContext context, int index) {
                var med = _favorites[index];

                return ListTile(
                  contentPadding: EdgeInsets.symmetric(horizontal: 20),
                  title: Text(
                    med.name,
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  subtitle: Text(med.medTypesToString()),
                  trailing: IconButton(
                    icon: Icon(Icons.star),
                    color: Colors.orangeAccent,
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
                      Scaffold.of(context).showSnackBar(snackbar);
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
                );
              },
            ),
          );
  }
}
