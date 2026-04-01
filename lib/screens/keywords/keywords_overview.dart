import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mpibrasil/assets.dart';
import 'package:mpibrasil/constants.dart';
import 'package:mpibrasil/generated/l10n.dart';
import 'package:mpibrasil/models/keyword.dart';
import 'package:mpibrasil/providers/keywords_provider.dart';
import 'package:mpibrasil/screens/keywords/keyword_details.dart';

class KeywordsOverview extends ConsumerStatefulWidget {
  @override
  ConsumerState<KeywordsOverview> createState() => _KeywordsOverviewState();
}

class _KeywordsOverviewState extends ConsumerState<KeywordsOverview> {
  var _isLoading = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _fetchKeywords();
    });
  }

  Future<void> _fetchKeywords() async {
    setState(() => _isLoading = true);
    await ref.read(keywordsNotifierProvider.notifier).fetchKeywordsFromDB();
    if (mounted) {
      setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final keywords = ref.watch(keywordsNotifierProvider).valueOrNull ?? [];

    final headerStyle = TextStyle(
      color: Colors.white,
      fontSize: 24,
      fontWeight: FontWeight.bold,
    );

    return Scaffold(
      backgroundColor: kColorMPIGreenOpaque,

      appBar: AppBar(
        backgroundColor: kColorMPIGreen,

        // page appbar
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
          child: Container(
            alignment: Alignment.centerLeft,
            padding: EdgeInsets.only(left: 20.0, bottom: 40),
            child: Text(S.current.keywordsPageTitle, style: headerStyle),
          ),
        ),
      ),

      // page content
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
        decoration: BoxDecoration(
          color: kColorMPIWhite,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(15.0),
            topRight: Radius.circular(15.0),
          ),
        ),
        child: Column(
          children: [
            Expanded(
              child: _isLoading
                  ? Center(
                      child: CircularProgressIndicator(
                        backgroundColor: Colors.white,
                        valueColor:
                            AlwaysStoppedAnimation<Color>(kColorMPIGreen),
                      ),
                    )
                  : KeywordList(keywords: keywords),
            ),
          ],
        ),
      ),
    );
  }
}

class KeywordList extends StatelessWidget {
  const KeywordList({Key? key, required this.keywords}) : super(key: key);

  final List<Keyword> keywords;

  @override
  Widget build(BuildContext context) {
    return Container(
      // keyword list
      child: ListView.separated(
        itemCount: keywords.length,
        separatorBuilder: (BuildContext context, int index) =>
            Divider(color: Colors.transparent),

        // draw keywords
        itemBuilder: (BuildContext context, int index) {
          return Card(
            color: kColorMPIGreenOpaque,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(kCardBorderRadius),
            ),
            child: ListTile(
              // card layout
              contentPadding: EdgeInsets.symmetric(
                horizontal: 20.0,
                vertical: 10.0,
              ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(kCardBorderRadius),
              ),

              // keyword
              title: Text(
                keywords[index].word,
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),

              // keyword info
              subtitle: keywords[index].synonyms == null
                  ? null
                  : Text(
                      keywords[index].synonymsListToString(),
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.normal,
                      ),
                    ),

              // tap action
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        KeywordDetails(keyword: keywords[index]),
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}
