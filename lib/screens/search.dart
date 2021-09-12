import 'package:diacritic/diacritic.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/meds.dart';
import '../providers/userpreferences.dart';
import '../screens/med_details.dart';
import '../widgets/drawer.dart';
import '../constants.dart';

class SearchPage extends StatefulWidget {
  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  var _isInit = true;
  var _isLoading = false;
  Widget resultPane = Center(child: Image.asset("assets/undraw/doctors.png"));

  @override
  void didChangeDependencies() {
    if (_isInit) {
      setState(() {
        _isLoading = true;
      });
      Provider.of<Meds>(context).fetchMedsFromDB().then((value) {
        setState(() {
          _isLoading = false;
        });
      });
    }
    _isInit = false;
    super.didChangeDependencies();
  }

  Widget drawResults(BuildContext context, String query) {
    final medsData = Provider.of<Meds>(context, listen: false);
    final meds = medsData.meds;

    if (query == null || query.isEmpty)
      return Center(child: Image.asset("assets/undraw/doctors.png"));
    else {
      final filteredMeds = meds
          .where((element) => removeDiacritics(element.name)
              .toUpperCase()
              .contains(removeDiacritics(query).toUpperCase()))
          .toList();
      if (filteredMeds.isEmpty) {
        return Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            Center(
              child: Column(
                children: <Widget>[
                  Image.asset(
                    "assets/undraw/doctors.png",
                    width: 128,
                  ),
                  Text(
                    "Nenhum resultado encontrado",
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
          ],
        );
      }

      return Container(
        child: ListView.separated(
          itemCount: filteredMeds.length,
          separatorBuilder: (BuildContext context, int index) => Divider(),
          itemBuilder: (BuildContext context, int index) {
            var isFavorite = Provider.of<UserPreferences>(context, listen: true)
                .isFavorite(filteredMeds[index].id);

            return ListTile(
              contentPadding: EdgeInsets.symmetric(horizontal: 20),
              title: Text(
                filteredMeds[index].name,
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              subtitle: Text(filteredMeds[index].medTypesToString()),
              trailing: IconButton(
                icon: isFavorite ? Icon(Icons.star) : Icon(Icons.star_border),
                color: Colors.orangeAccent,
                onPressed: () {
                  Provider.of<UserPreferences>(context, listen: false)
                      .toggleFavorite(filteredMeds[index].id);
                },
              ),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => MedDetails(med: filteredMeds[index]),
                  ),
                );
              },
            );
          },
        ),
      );
    }
  }

  void _queryMed(String query) {
    // updates search query to draw results
    setState(() {
      resultPane = drawResults(context, query);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('MPI Brasil'),
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(80),
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
            child: TextField(
              onChanged: _queryMed,
              decoration: InputDecoration(
                contentPadding: EdgeInsets.all(kInputContentPadding),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(kInputBorderRadius),
                ),
                suffixIcon: Icon(Icons.search),
                fillColor: Colors.white,
                filled: true,
                hintText: "Pesquisar...",
              ),
            ),
          ),
        ),
      ),
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 5.0, vertical: 10.0),
        color: Colors.white,
        child: _isLoading
            ? Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  Center(
                      child: CircularProgressIndicator(
                    backgroundColor: Colors.white,
                    valueColor: AlwaysStoppedAnimation<Color>(Colors.green),
                  )),
                  Text("Carregando dados..."),
                ],
              )
            : resultPane,
      ),
      drawer: AppDrawer(),
    );
  }
}
