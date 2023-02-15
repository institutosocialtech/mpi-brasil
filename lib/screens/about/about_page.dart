import 'package:flutter/material.dart';
import 'package:flutter_mailer/flutter_mailer.dart';
import 'package:markdown_widget/markdown_widget.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:mpibrasil/constants.dart';

import '../onboarding/onboarding.dart';
import 'tos_page.dart';
import 'privacy_page.dart';
import 'equipe_page.dart';

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
            'assets/images/med_composition.png',
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
            child: Text('SOBRE', style: headerStyle),
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

  final introduction =
      'O **Aplicativo MPI Brasil** é um instrumento de busca rápida sobre os Medicamentos Potencialmente Inapropriados para Idosos (MPIs), disponíveis no Brasil, para auxiliar profissionais de saúde na tomada de decisão clínica.';
  final development =
      'Esta segunda versão do aplicativo foi desenvolvido pelo **Instituto SocialTech**, juntamente com a **Universidade Federal da Bahia (UFBA)**, por meio do Instituto Multidisciplinar em Saúde - Campus Anísio Teixeira (IMS-CAT/UFBA) e pela **Universidade Estadual do Sudoeste da Bahia (UESB)**, por meio do Curso de Medicina, Campus de Vitória da Conquista.';

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
                      child: Image.asset("assets/images/app_icon_android.png",
                          fit: BoxFit.fill),
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
                            ' MPI Brasil',
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
                                    'v${snapshot.data.version}',
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
                            'SocialTech © 2023 Company',
                            style: TextStyle(
                              // fontWeight: FontWeight.bold,
                              fontSize: 12,
                            ),
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
                    ...MarkdownGenerator(
                        data: introduction,
                        styleConfig: StyleConfig(
                          pConfig: PConfig(
                            textConfig:
                                TextConfig(textAlign: TextAlign.justify),
                          ),
                        )).widgets,
                    ...MarkdownGenerator(
                        data: development,
                        styleConfig: StyleConfig(
                          pConfig: PConfig(
                            textConfig:
                                TextConfig(textAlign: TextAlign.justify),
                          ),
                        )).widgets,
                  ],
                )),
          ],
        ),
        Divider(color: kColorMPIDividerGray),
        ListTile(
          title: Text(
            'Equipe',
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
            'Licenças',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          trailing: IconButton(
              icon: Icon(Icons.keyboard_arrow_right),
              color: Colors.grey,
              onPressed: () {
                showLicensePage(context: context);
              }),
          onTap: () {
            showLicensePage(context: context);
          },
        ),
        Divider(color: kColorMPIDividerGray),
        ListTile(
          title: Text(
            'Termo de Uso',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          trailing: IconButton(
              icon: Icon(Icons.keyboard_arrow_right),
              color: Colors.grey,
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => TermsOfUsePage(),
                  ),
                );
              }),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => TermsOfUsePage(),
              ),
            );
          },
        ),
        Divider(color: kColorMPIDividerGray),
        ListTile(
          title: Text(
            'Política de Privacidade',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          trailing: IconButton(
              icon: Icon(Icons.keyboard_arrow_right),
              color: Colors.grey,
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => PrivacyPolicyPage(),
                  ),
                );
              }),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => PrivacyPolicyPage(),
              ),
            );
          },
        ),
        Divider(color: kColorMPIDividerGray),
        ListTile(
          title: Text(
            'Fale Conosco',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          trailing: IconButton(
              icon: Icon(Icons.keyboard_arrow_right),
              color: Colors.grey,
              onPressed: () {
                final MailOptions mailOptions = MailOptions(
                  body:
                      ' Conte-nos a sua opinião, ela é muito importante para nós!',
                  subject: "Fale Conosco",
                  recipients: ['mpibrasil@socialtech.org.br'],
                  isHTML: true,
                );

                FlutterMailer.send(mailOptions);
              }),
          onTap: () {
            final MailOptions mailOptions = MailOptions(
              body:
                  ' Conte-nos a sua opinião, ela é muito importante para nós!',
              subject: "Fale Conosco",
              recipients: ['mpibrasil@socialtech.org.br'],
              isHTML: true,
            );

            FlutterMailer.send(mailOptions);
          },
        ),
        Divider(color: kColorMPIDividerGray),
      ],
    );
  }
}
