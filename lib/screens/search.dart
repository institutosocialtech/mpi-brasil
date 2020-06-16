import 'package:diacritic/diacritic.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/meds.dart';
import '../screens/med_details.dart';
import '../widgets/drawer.dart';

class SearchPage extends StatefulWidget {
  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  var _isInit = true;
  var _isLoading = false;
  Widget resultPane = Center(child: Image.asset("assets/images/logo.png"));

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
    final medsData = Provider.of<Meds>(context);
    final meds = medsData.meds;

    if (query == null || query.isEmpty)
      return Center(child: Image.asset("assets/images/logo.png"));
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
                  Text("Não foram encontrados resultados\npara o termo pesquisado",textAlign: TextAlign.center,),
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
            return ListTile(
              contentPadding: EdgeInsets.symmetric(horizontal: 20),
              title: Text(
                filteredMeds[index].name,
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              subtitle: Text(filteredMeds[index].medTypesToString()),
              trailing: IconButton(
                  icon: Icon(Icons.star_border),
                  color: Colors.orangeAccent,
                  onPressed: () {
                    print("setFavorite \"" + filteredMeds[index].name + "\"");
                  }),
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('MPI Brasil'),
        titleSpacing: 0.0,
        elevation: 0,
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(80),
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
            child: TextField(
              onChanged: (query) {
                setState(() {
                  resultPane = drawResults(context, query);
                });
              },
              decoration: InputDecoration(
                contentPadding: EdgeInsets.all(10),
                border:
                    OutlineInputBorder(borderRadius: BorderRadius.circular(15)),
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
