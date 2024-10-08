import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:material_symbols_icons/symbols.dart';
import 'package:mpibrasil/assets.dart';
import 'package:mpibrasil/constants.dart';
import 'package:mpibrasil/generated/l10n.dart';

class DespResultPage extends StatelessWidget {
  final Color bgColor;
  final String resultTitle;
  final String resultContentList;

  const DespResultPage({
    Key? key,
    required this.bgColor,
    required this.resultTitle,
    required this.resultContentList,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final contentList = resultContentList.split('\$');

    final contentWidgets = contentList.map((entry) {
      return ListTile(
        leading: Icon(Symbols.outpatient_med, color: Colors.black),
        title: Text(entry),
        titleTextStyle: Theme.of(context)
            .textTheme
            .bodyLarge!
            .copyWith(color: Colors.black),
      );
    }).toList();

    return Scaffold(
      backgroundColor: bgColor,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              children: [
                // result image
                Padding(
                  padding: const EdgeInsets.only(bottom: 25.0),
                  child: SvgPicture.asset(MpiAssets.svgGroup3),
                ),

                // result title
                Padding(
                  padding: const EdgeInsets.only(bottom: 25.0),
                  child: Text(
                    resultTitle,
                    textAlign: TextAlign.center,
                    style: Theme.of(context)
                        .textTheme
                        .headlineMedium!
                        .copyWith(fontWeight: FontWeight.bold),
                  ),
                ),

                // result content
                ...contentWidgets,

                // footer
                Padding(
                  padding: const EdgeInsets.only(top: 20.0),
                  child: ElevatedButton(
                    onPressed: () => Navigator.of(context).pop(),
                    child: Text(S.current.close.toUpperCase()),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: kColorMPIWhite,
                      foregroundColor: Colors.black,
                      textStyle: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
