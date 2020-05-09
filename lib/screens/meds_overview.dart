import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/med.dart';
import '../providers/meds.dart';
import '../screens/med_details.dart';

class MedsOverview extends StatelessWidget {
  final headerStyle = TextStyle(
    color: Colors.white,
    fontWeight: FontWeight.bold,
  );

  @override
  Widget build(BuildContext context) {
    final medsData = Provider.of<Meds>(context);
    final meds = medsData.meds;

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
                  child: Text("Medicamentos".toUpperCase(),
                      textScaleFactor: 1.5, style: headerStyle),
                ),
              ],
            ),
          ),
          Expanded(child: MedList(meds: meds)),
        ],
      ),
    );
  }
}

class MedList extends StatelessWidget {
  const MedList({Key key, @required this.meds}) : super(key: key);
  final List<Med> meds;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: ListView.separated(
        itemCount: meds.length,
        separatorBuilder: (BuildContext context, int index) => Divider(),
        itemBuilder: (BuildContext context, int index) {
          return ListTile(
            contentPadding: EdgeInsets.symmetric(horizontal: 20),
            title: Text(
              meds[index].name,
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            subtitle: Text(meds[index].medTypesToString()),
            trailing: IconButton(
                icon: Icon(Icons.star_border),
                color: Colors.orangeAccent,
                onPressed: () {
                  print("setFavorite \"" + meds[index].name + "\"");
                }),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => MedDetails(med: meds[index]),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
