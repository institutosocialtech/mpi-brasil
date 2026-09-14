// widgets/result_page_base.dart
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:material_symbols_icons/material_symbols_icons.dart';
import 'package:mpibrasil/constants.dart';

class ResultPageBase extends StatelessWidget {
  final String title;
  final String svgAsset;
  final List<Widget> contentWidgets;
  final VoidCallback onClose;

  const ResultPageBase({
    super.key,
    required this.title,
    required this.svgAsset,
    required this.contentWidgets,
    required this.onClose,
  });

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Symbols.close),
          onPressed: onClose,
        ),
        backgroundColor: kColorMPIGreenOpaque,
        title: Text(
          title,
          style: const TextStyle(
            color: Colors.black,
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),
      backgroundColor: kColorMPIGreenOpaque,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(bottom: 25.0),
                  child: SvgPicture.asset(
                    svgAsset,
                    height: size.height * 0.20,
                  ),
                ),
                ...contentWidgets,
              ],
            ),
          ),
        ),
      ),
    );
  }
}