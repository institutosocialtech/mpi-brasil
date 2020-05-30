import 'package:flutter/material.dart';
import 'package:flutter_mailer/flutter_mailer.dart';
import 'package:mpibrasil/screens/terms_of_use_page.dart';
import 'package:mpibrasil/screens/privacy_policy_page.dart';
import 'package:mpibrasil/screens/equipe_page.dart';

class AboutPage extends StatelessWidget {
  final medTitleStyle =
      TextStyle(fontWeight: FontWeight.bold, color: Colors.white);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('MPI Brasil'),
        titleSpacing: 0.0,
        elevation: 0,
      ),
      body: Column(
        children: <Widget>[
          Container(
            height: 80,
            color: Colors.green,
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Text("Sobre".toUpperCase(), textScaleFactor: 1.5, style: medTitleStyle),
              ],
            ),
          ),
          Expanded(
            child: AboutList(),
          ),
        ],
      ),
    );
  }
}

class AboutList extends StatelessWidget {
  final medTitleStyle =
      TextStyle(fontWeight: FontWeight.bold, color: Colors.white);
  @override
  Widget build(BuildContext context) {
    return Container(
        child: ListView(
      padding: EdgeInsets.zero,
      children: <Widget>[
        Column(
          children: [
            Container(
              padding: EdgeInsets.only(left:20, top: 20, right: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    width: 100,
                    height: 100,
                    child:
                        Image.asset("assets/images/logo.png", fit: BoxFit.fill),
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
                          child: Text(
                            '2.0.25',
                            style: TextStyle(
                              // fontWeight: FontWeight.bold,
                              fontSize: 12,
                            ),
                            textAlign: TextAlign.justify,
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.only(bottom: 8),
                          child: Text(
                            ' PMSOCIAL © 2019 Company',
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
              child: Text(
                ' O Aplicativo MPI Brasil é um instrumento de busca rápida sobre os Medicamentos Potencialmente Inapropriados para Idosos (MPIs), disponíveis no Brasil, para auxiliar profissionais de saúde na tomada de decisão clínica.\n  Este aplicativo foi desenvolvido pelo Instituto PMO Social, juntamente com a Universidade Federal da Bahia (UFBA), por meio do Instituto Multidisciplinar em Saúde- Campus Anísio Teixeira (IMS-CAT/UFBA) e pela Universidade Estadual do Sudoeste da Bahia (UESB), por meio do Curso de Medicina, Campus de Vitória da Conquista.',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 14,
                ),
                textAlign: TextAlign.justify,
              ),
            ),
          ],
        ),
        Divider(),
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
        Divider(),
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
        Divider(),
        ListTile(
          title: Text(
            'Quem Somos/Equipe',
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
        Divider(),
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
        Divider(),
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
                  recipients: ['mpibrasil@pmosocial.org'],
                  isHTML: true,
                );

                FlutterMailer.send(mailOptions);
              }),
          onTap: () {
            final MailOptions mailOptions = MailOptions(
              body:
                  ' Conte-nos a sua opinião, ela é muito importante para nós!',
              subject: "Fale Conosco",
              recipients: ['mpibrasil@pmosocial.org'],
              isHTML: true,
            );

            FlutterMailer.send(mailOptions);
          },
        ),
        Divider(),
      ],
    ));
  }
}
