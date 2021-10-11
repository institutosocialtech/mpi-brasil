import 'package:diacritic/diacritic.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_svg/svg.dart';

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

  Widget resultPane = Center(
    child: SvgPicture.asset('assets/undraw_svg/doctors.svg'),
  );

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

    if (query == null || query.isEmpty) {
      // return image if no query has been done
      return Center(
        child: SvgPicture.asset("assets/undraw_svg/doctors.svg"),
      );

      // process query
    } else {
      // filter med list based on query
      final filteredMeds = meds
          .where((element) => removeDiacritics(element.name)
              .toUpperCase()
              .contains(removeDiacritics(query).toUpperCase()))
          .toList();

      // display msg if results are empty
      if (filteredMeds.isEmpty) {
        return Column(
          children: <Widget>[
            Column(
              children: <Widget>[
                Divider(
                  indent: 50,
                  endIndent: 50,
                  thickness: 4.0,
                  color: kColorMPIRed,
                ),
                Text(
                  "Nenhum resultado encontrado",
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ],
        );
      }

      // draw results
      return ListView.separated(
        itemCount: filteredMeds.length,
        separatorBuilder: (BuildContext context, int index) =>
            Divider(color: Colors.transparent),

        // draw med tiles
        itemBuilder: (BuildContext context, int index) {
          var isFavorite = Provider.of<UserPreferences>(context, listen: true)
              .isFavorite(filteredMeds[index].id);

          return Card(
            color: kColorMPIGreenOpaque,
            child: ListTile(
              // card layout
              contentPadding: EdgeInsets.symmetric(
                horizontal: 20.0,
                vertical: 10.0,
              ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(kCardBorderRadius),
              ),

              // card title
              title: Text(
                filteredMeds[index].name,
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),

              // card info
              subtitle: Text(
                filteredMeds[index].medTypesToString(),
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.normal,
                ),
              ),

              // trailing button
              trailing: IconButton(
                icon: isFavorite ? Icon(Icons.star) : Icon(Icons.star_border),
                color: Colors.white,
                onPressed: () {
                  Provider.of<UserPreferences>(context, listen: false)
                      .toggleFavorite(filteredMeds[index].id);
                },
              ),

              // tap action
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => MedDetails(med: filteredMeds[index]),
                  ),
                );
              },
            ),
          );
        },
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
      backgroundColor: kColorMPIGreenOpaque,
      // page appbar
      appBar: AppBar(
        backgroundColor: kColorMPIGreen,

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
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
            child: TextField(
              onChanged: _queryMed,
              decoration: InputDecoration(
                contentPadding: EdgeInsets.all(kInputContentPadding),
                suffixIcon: Icon(Icons.search, color: kColorMPIGray),
                hintText: "Pesquisar...",
              ),
            ),
          ),
        ),
      ),

      // app drawer
      drawer: AppDrawer(),

      // page content
      body: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
          decoration: BoxDecoration(
            color: kColorMPIWhite,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(15.0),
              topRight: Radius.circular(15.0),
            ),
          ),
          child: _isLoading
              ? Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[
                    Center(
                      child: CircularProgressIndicator(
                        backgroundColor: kColorMPIWhite,
                        valueColor:
                            AlwaysStoppedAnimation<Color>(kColorMPIGreen),
                      ),
                    ),
                    Text("Carregando dados..."),
                  ],
                )
              : resultPane,
        ),
      ),
    );
  }
}
