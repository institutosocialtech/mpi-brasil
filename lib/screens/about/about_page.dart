import 'package:flutter/material.dart';
import 'package:flutter_mailer/flutter_mailer.dart';
import 'package:markdown_widget/markdown_widget.dart';
import 'package:mpibrasil/assets.dart';
import 'package:mpibrasil/constants.dart';
import 'package:mpibrasil/generated/l10n.dart';
import 'package:mpibrasil/screens/about/equipe_page.dart';
import 'package:mpibrasil/screens/about/privacy_page.dart';
import 'package:mpibrasil/screens/about/tos_page.dart';
import 'package:mpibrasil/screens/onboarding/onboarding.dart';
import 'package:package_info_plus/package_info_plus.dart';

class AboutPage extends StatelessWidget {
  final headerStyle = TextStyle(
    color: Colors.white,
    fontSize: 24,
    fontWeight: FontWeight.bold,
  );

  @override
  Widget build(BuildContext context) {
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
            child: Text(S.current.aboutPageTitle, style: headerStyle),
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
        child: AboutList(),
      ),
    );
  }
}

class AboutList extends StatelessWidget {
  final medTitleStyle = TextStyle(
    fontWeight: FontWeight.bold,
    color: Colors.white,
  );

  @override
  Widget build(BuildContext context) {
    var tapCount = 0;

    return ListView(
      padding: EdgeInsets.zero,
      children: <Widget>[
        Column(
          children: [
            Container(
              padding: EdgeInsets.only(left: 20, top: 20, right: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    width: 100,
                    height: 100,
                    child: InkWell(
                      child: Image.asset(
                        MpiAssets.iconAndroid,
                        fit: BoxFit.fill,
                      ),
                      onTap: () {
                        if (tapCount == 4) {
                          tapCount = 0;
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => OnboardingScreen()),
                          );
                        } else {
                          tapCount++;
                        }
                      },
                    ),
                  ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          padding: const EdgeInsets.only(bottom: 8),
                          child: Text(
                            S.current.appTitle,
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 14,
                            ),
                            textAlign: TextAlign.justify,
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.only(bottom: 8),
                          child: FutureBuilder<PackageInfo>(
                            future: PackageInfo.fromPlatform(),
                            builder: (context, snapshot) {
                              switch (snapshot.connectionState) {
                                case ConnectionState.done:
                                  return Text(
                                    'v${snapshot.data!.version}',
                                    style: TextStyle(fontSize: 12),
                                    textAlign: TextAlign.center,
                                  );
                                default:
                                  return Text('');
                              }
                            },
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.only(bottom: 8),
                          child: Text(
                            S.current.socialTechCopyright,
                            style: TextStyle(fontSize: 12),
                            textAlign: TextAlign.justify,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Container(
              padding: const EdgeInsets.only(left: 20, right: 20),
              child: Column(
                children: <Widget>[
                  // TODO: MarkdownGenerator: fix textConfig(TextAlign.justify)
                  ...MarkdownGenerator()
                      .buildWidgets(S.current.aboutIntroMarkdown),
                  ...MarkdownGenerator()
                      .buildWidgets(S.current.aboutDevelopmentMarkdown),
                ],
              ),
            ),
          ],
        ),
        Divider(color: kColorMPIDividerGray),
        ListTile(
          title: Text(
            S.current.aboutTeamTileTitle,
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          trailing: IconButton(
              icon: Icon(Icons.keyboard_arrow_right),
              color: Colors.grey,
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => EquipePage(),
                  ),
                );
              }),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => EquipePage(),
              ),
            );
          },
        ),
        Divider(color: kColorMPIDividerGray),
        ListTile(
          title: Text(
            S.current.aboutLicensesTileTitle,
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          trailing: IconButton(
              icon: Icon(Icons.keyboard_arrow_right),
              color: Colors.grey,
              onPressed: () => showLicensePage(context: context)),
          onTap: () => showLicensePage(context: context),
        ),
        Divider(color: kColorMPIDividerGray),
        ListTile(
          title: Text(
            S.current.aboutTosTileTitle,
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          trailing: IconButton(
            icon: Icon(Icons.keyboard_arrow_right),
            color: Colors.grey,
            onPressed: () => Navigator.push(context,
                MaterialPageRoute(builder: (context) => TermsOfUsePage())),
          ),
          onTap: () => Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => TermsOfUsePage()),
          ),
        ),
        Divider(color: kColorMPIDividerGray),
        ListTile(
          title: Text(
            S.current.aboutPrivacyPolicyTileTitle,
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          trailing: IconButton(
            icon: Icon(Icons.keyboard_arrow_right),
            color: Colors.grey,
            onPressed: () => Navigator.push(context,
                MaterialPageRoute(builder: (context) => PrivacyPolicyPage())),
          ),
          onTap: () => Navigator.push(context,
              MaterialPageRoute(builder: (context) => PrivacyPolicyPage())),
        ),
        Divider(color: kColorMPIDividerGray),
        ListTile(
          title: Text(
            S.current.aboutContactTileTitle,
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          trailing: IconButton(
            icon: Icon(Icons.keyboard_arrow_right),
            color: Colors.grey,
            onPressed: () => _aboutEmailSend(),
          ),
          onTap: () => _aboutEmailSend(),
        ),
        Divider(color: kColorMPIDividerGray),
      ],
    );
  }

  void _aboutEmailSend() {
    final MailOptions mailOptions = MailOptions(
      recipients: [S.current.socialTechEmail],
      subject: S.current.aboutContactMailSubject,
      body: S.current.aboutContactMailBody,
      isHTML: true,
    );

    FlutterMailer.send(mailOptions);
  }
}
