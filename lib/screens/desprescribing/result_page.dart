import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:material_symbols_icons/symbols.dart';
import 'package:mpibrasil/assets.dart';
import 'package:mpibrasil/constants.dart';
import 'package:mpibrasil/generated/l10n.dart';
import 'package:mpibrasil/screens/desprescribing/result_card.dart';

class DespResultPage extends StatelessWidget {
  const DespResultPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final headerStyle = TextStyle(
      color: Colors.black,
      fontSize: 24,
      fontWeight: FontWeight.bold,
    );

    return Scaffold(
      // scaffold appbar
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Symbols.close),
          onPressed: () =>
              Navigator.of(context).popUntil((route) => route.isFirst),
        ),
        backgroundColor: kColorMPIGreenOpaque,
        title: Text('Resultado', style: headerStyle),
        centerTitle: true,
      ),
      // scaffold bg color
      backgroundColor: kColorMPIGreenOpaque,
      // scaffold body
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              children: [
                // svg undraw
                Padding(
                  padding: const EdgeInsets.only(bottom: 25.0),
                  child: SvgPicture.asset(
                    MpiAssets.svgUndrawMedicalCare,
                    height: size.height * 0.20,
                    // colorFilter: ColorFilter.mode(
                    //   kColorMPIGreenOpaque,
                    //   BlendMode.colorBurn,
                    // ),
                  ),
                ),

                Padding(
                  padding: const EdgeInsets.only(bottom: 25.0),
                  child: ResultCard(
                    title: S.current.considerDeprescribingTitle,
                    iconData: Symbols.pill_off,
                    iconColor: kColorMPIRed,
                    contentList:
                        S.current.considerDeprescribingList.split('\$'),
                  ),
                ),

                Padding(
                  padding: const EdgeInsets.only(bottom: 25.0),
                  child: ResultCard(
                    title: S.current.considerNotDeprescribingTitle,
                    iconData: Symbols.pill,
                    iconColor: kColorMPIGreen,
                    contentList:
                        S.current.considerNotDeprescribingList.split('\$'),
                  ),
                ),

                Padding(
                  padding: const EdgeInsets.only(bottom: 25.0),
                  child: ResultCard(
                    isNumbered: true,
                    title: S.current.howToDeprescribeTitle,
                    contentList: S.current.howToDeprescribeList.split('\$'),
                  ),
                ),

                Padding(
                  padding: const EdgeInsets.only(bottom: 25.0),
                  child: ResultCard(
                    isNumbered: true,
                    title: S.current.howToMonitorTitle,
                    contentList: S.current.howToMonitorList.split('\$'),
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
