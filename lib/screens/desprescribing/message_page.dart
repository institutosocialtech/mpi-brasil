import 'package:flutter/material.dart';
import 'package:flutter_linkify/flutter_linkify.dart';
import 'package:flutter_svg/svg.dart';
import 'package:material_symbols_icons/material_symbols_icons.dart';
import 'package:mpibrasil/constants.dart';
import 'package:url_launcher/url_launcher.dart';

class QuizResultPage extends StatelessWidget {
  final String title;
  final String message;
  final String svgAsset;

  const QuizResultPage(
      {required this.title,
      required this.message,
      required this.svgAsset,
      super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final headerStyle = TextStyle(
      color: Colors.black,
      fontSize: 24,
      fontWeight: FontWeight.bold,
    );

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Symbols.close),
          onPressed: () =>
              Navigator.of(context).popUntil((route) => route.isFirst),
        ),
        backgroundColor: Colors.white,
        title: Text('Resultado', style: headerStyle),
        centerTitle: true,
      ),

      // scaffold bg color
      backgroundColor: Colors.white,

      // message body
      body: SafeArea(
        child: Container(
          padding: EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // image header
              Padding(
                padding: const EdgeInsets.only(bottom: 25.0),
                child: SvgPicture.asset(
                  svgAsset,
                  height: size.height * 0.20,
                ),
              ),

              // title
              Padding(
                padding: const EdgeInsets.only(bottom: 25.0),
                child: Text(
                  this.title,
                  textAlign: TextAlign.center,
                  style: Theme.of(context)
                      .textTheme
                      .headlineSmall!
                      .copyWith(fontWeight: FontWeight.bold),
                ),
              ),

              // message
              Padding(
                padding: const EdgeInsets.only(top: 20.0),
                child: Linkify(
                  text: message,
                  textAlign: TextAlign.center,
                  onOpen: (link) async {
                    final uri = Uri.parse(link.url);
                    if (await canLaunchUrl(uri)) {
                      await launchUrl(uri,
                          mode: LaunchMode.externalApplication);
                    }
                  },
                  style: Theme.of(context)
                      .textTheme
                      .bodyLarge!
                      .copyWith(fontWeight: FontWeight.normal),
                  linkStyle: Theme.of(context).textTheme.bodyLarge!.copyWith(
                        fontWeight: FontWeight.bold,
                        color: kColorMPIGreen,
                      ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
