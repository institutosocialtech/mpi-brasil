import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/drug.dart';
import '../providers/drugs.dart';
import '../screens/medicamento_info.dart';

class Favorites extends StatelessWidget {
  final headerStyle =
      TextStyle(color: Colors.white, fontWeight: FontWeight.bold);

  @override
  Widget build(BuildContext context) {
    final favoriteData = Provider.of<Drugs>(context);
    final favorites = favoriteData.drugs;

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
                      Text("Favoritos", textScaleFactor: 2, style: headerStyle),
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
  final List<Drug> favorites;

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
            subtitle: Text(favorites[index].drugTypesToString()),
            trailing: IconButton(
                icon: Icon(Icons.star), color: Colors.orange, onPressed: () {}),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => MedicamentoInfo(drug: favorites[index]),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
