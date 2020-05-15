import 'package:flutter/material.dart';
import 'package:mpibrasil/widgets/drawer.dart';
import 'package:provider/provider.dart';
import '../models/med.dart';
import '../providers/meds.dart';
import '../screens/med_details.dart';

class SearchPage extends StatefulWidget {
  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  var _isInit = true;
  var _isLoading = false;

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
            ? Center(child: CircularProgressIndicator())
            : Center(child: Image.asset("assets/images/logo.jpg")),
      ),
      drawer: AppDrawer(),
    );
  }
}

class MPISearch extends SearchDelegate<Med> {
  @override
  List<Widget> buildActions(BuildContext context) {
    return [Container()];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return Container();
  }

  @override
  Widget buildResults(BuildContext context) {
    return Container();
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return Container();
  }
}
