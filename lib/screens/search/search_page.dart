import 'package:diacritic/diacritic.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mpibrasil/assets.dart';
import 'package:mpibrasil/constants.dart';
import 'package:mpibrasil/generated/l10n.dart';
import 'package:mpibrasil/models/med.dart';
import 'package:mpibrasil/providers/meds_provider.dart';
import 'package:mpibrasil/providers/user_preferences_provider.dart';
import 'package:mpibrasil/screens/search/med_details.dart';
import 'package:mpibrasil/widgets/drawer.dart';

class SearchPage extends ConsumerStatefulWidget {
  @override
  ConsumerState<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends ConsumerState<SearchPage> {
  var _isLoading = false;
  String _searchQuery = '';

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _fetchMeds();
    });
  }

  Future<void> _fetchMeds() async {
    setState(() => _isLoading = true);
    await ref.read(medsNotifierProvider.notifier).fetchMedsFromDB();
    if (mounted) {
      setState(() => _isLoading = false);
    }
  }

  List<Med> _getFilteredMeds(List<Med> meds) {
    if (_searchQuery.isEmpty) {
      return meds;
    }
    return meds
        .where((element) => removeDiacritics(element.name)
            .toUpperCase()
            .contains(removeDiacritics(_searchQuery).toUpperCase()))
        .toList();
  }

  void _queryMed(String query) {
    setState(() {
      _searchQuery = query;
    });
  }

  @override
  Widget build(BuildContext context) {
    final medsAsync = ref.watch(medsNotifierProvider);
    final meds = medsAsync.valueOrNull ?? [];
    final filteredMeds = _getFilteredMeds(meds);

    return Scaffold(
      backgroundColor: kColorMPIGreenOpaque,
      // page appbar
      appBar: AppBar(
        backgroundColor: kColorMPIGreen,

        flexibleSpace: Container(
          child: Image.asset(
            MpiAssets.imgMedComposition,
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
              autofocus: false,
              onChanged: _queryMed,
              decoration: InputDecoration(
                fillColor: kColorMPIWhite,
                hintText: S.current.searchHintText,
                suffixIcon: Icon(Icons.search, color: kColorMPIGray),
              ),
            ),
          ),
        ),
      ),

      // app drawer
      drawer: AppDrawer(),

      // page content
      body: GestureDetector(
        onTap: () => FocusScope.of(context).requestFocus(FocusNode()),
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
                    Text(S.current.searchLoadingData),
                  ],
                )
              : _buildResultPane(filteredMeds),
        ),
      ),
    );
  }

  Widget _buildResultPane(List<Med> filteredMeds) {
    if (filteredMeds.isEmpty && _searchQuery.isNotEmpty) {
      return Center(
        child: Text(
          S.current.searchResultsNotFound,
          textAlign: TextAlign.center,
        ),
      );
    }

    if (filteredMeds.isEmpty) {
      return Center(
        child: FractionallySizedBox(
          widthFactor: 0.9,
          child: Image.asset(MpiAssets.logoMPIGreen),
        ),
      );
    }

    return ListView.separated(
      itemCount: filteredMeds.length,
      separatorBuilder: (BuildContext context, int index) =>
          Divider(color: Colors.transparent),
      itemBuilder: (BuildContext context, int index) {
        final med = filteredMeds[index];
        return _MedListTile(med: med);
      },
    );
  }
}

class _MedListTile extends ConsumerWidget {
  final Med med;

  const _MedListTile({required this.med});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userPrefs = ref.watch(userPreferencesNotifierProvider);
    final isFavorite = userPrefs.favorites?.containsKey(med.id) ?? false;

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
          med.name,
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),

        // card info
        subtitle: Text(
          med.medTypesToString(),
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
            ref.read(userPreferencesNotifierProvider.notifier).toggleFavorite(med.id);
          },
        ),

        // tap action
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
  }
}
