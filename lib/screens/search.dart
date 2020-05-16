import 'package:flutter/material.dart';
import 'package:mpibrasil/widgets/drawer.dart';
import 'package:provider/provider.dart';
import '../models/med.dart';
import '../providers/meds.dart';
import '../screens/med_details.dart';
import 'package:diacritic/diacritic.dart';

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
      final filtered_meds = meds
          .where((element) =>
              removeDiacritics(element.name).toUpperCase().contains(removeDiacritics(query).toUpperCase()))
          .toList();
      if (filtered_meds.isEmpty){
          return Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  // Center(child: Image.asset("assets/images/logo.png")),
                  Center(child: Text("não foram encontrados resultados para o termo pesquisado.")),
                ],
              );
      }
      // debug
      // print(filtered_meds.map((e) => e.name).toList());

      return Container(
        child: ListView.separated(
          itemCount: filtered_meds.length,
          separatorBuilder: (BuildContext context, int index) => Divider(),
          itemBuilder: (BuildContext context, int index) {
            return ListTile(
              contentPadding: EdgeInsets.symmetric(horizontal: 20),
              title: Text(
                filtered_meds[index].name,
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              subtitle: Text(filtered_meds[index].medTypesToString()),
              trailing: IconButton(
                  icon: Icon(Icons.star_border),
                  color: Colors.orangeAccent,
                  onPressed: () {
                    print("setFavorite \"" + filtered_meds[index].name + "\"");
                  }),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => MedDetails(med: filtered_meds[index]),
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
                setState((){
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
        child: _isLoading
            ? Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  Center(child: CircularProgressIndicator()),
                  Text("Carregando dados..."),
                ],
              )
            : resultPane,
      ),
      drawer: AppDrawer(),
    );
  }
}
