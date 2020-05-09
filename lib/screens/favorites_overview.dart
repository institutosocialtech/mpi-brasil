import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/med.dart';
import '../providers/meds.dart';
import '../screens/med_details.dart';

class FavoritesOverview extends StatelessWidget {
  final headerStyle =
      TextStyle(color: Colors.white, fontWeight: FontWeight.bold);

  @override
  Widget build(BuildContext context) {
    final favoriteData = Provider.of<Meds>(context);
    final favorites = favoriteData.meds;

    return Scaffold(
      body: Column(
        children: <Widget>[
          Container(
            height: 80,
            color: Colors.green,
            child: Row(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child:
                      Text("Favoritos".toUpperCase(), textScaleFactor: 1.5, style: headerStyle),
                ),
              ],
            ),
          ),
          Expanded(child: FavoriteList(favorites: favorites)),
        ],
      ),
    );
  }
}

class FavoriteList extends StatelessWidget {
  const FavoriteList({Key key, @required this.favorites}) : super(key: key);
  final List<Med> favorites;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: ListView.separated(
        itemCount: favorites.length,
        separatorBuilder: (BuildContext context, int index) => Divider(),
        itemBuilder: (BuildContext context, int index) {
          return ListTile(
            contentPadding: EdgeInsets.symmetric(horizontal: 20),
            title: Text(
              favorites[index].name,
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            subtitle: Text(favorites[index].medTypesToString()),
            trailing: IconButton(
                icon: Icon(Icons.star), color: Colors.orange, onPressed: () {}),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => MedDetails(med: favorites[index]),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
