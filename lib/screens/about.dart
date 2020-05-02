import 'package:flutter/material.dart';
import 'package:flutter_mailer/flutter_mailer.dart';
import 'package:mpibrasil/screens/terms_use.dart';
import 'package:mpibrasil/screens/privacy_policy.dart';
import 'package:mpibrasil/screens/license.dart';

class About extends StatelessWidget {
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
            color: Colors.green,
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Text("Sobre", textScaleFactor: 1.5, style: medTitleStyle),
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
        ListTile(
            title: Text(
              'App MPI Brasil',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            onTap: () => showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    title: Container(
                      color: Colors.green,
                      padding:
                          EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Text("O que é o App MPI Brasil",
                              style: medTitleStyle),
                        ],
                      ),
                    ),
                    // Text("O que é o App MPI Brasil"),
                    content: Text(
                      " É um instrumento de busca rápida sobre os MPI disponíveis no Brasil, auxiliando o médico no momento da tomada de decisão sobre qual medicamento seria mais apropriado para o paciente idoso. Além de listar os medicamentos considerados MPI, o aplicativo traz informações se o medicamento é MPI independente de condição clínica, se sim, qual o racional para isto e as situações de uso tidas como exceções. Cita se há alguma condição clínica específica que o medicamento deve ser evitado, quais as alternativas terapêuticas mais apropriadas disponíveis e, quando um medicamento não pode ser suspenso subitamente, dá as orientações de desmame (desprescrição). Além disso, caso seja necessário utilizar o MPI, o aplicativo fornece as orientações de monitoramento para tornar o uso do MPI mais seguro. Por fim, as referências bibliográficas utilizadas para cada MPI são disponibilizadas. Há também um glossário de termos médicos utilizados no aplicativo para melhor compreensão.",
                      style: TextStyle(
                        fontSize: 14,
                      ),
                      textAlign: TextAlign.justify,
                    ),
                  );
                })),
        Divider(),
        ListTile(
          title: Text(
            'Versão',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          subtitle: Text(
            "2.1",
            style: TextStyle(
              fontSize: 15,
            ),
            textAlign: TextAlign.justify,
          ),
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
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => License(),
                  ),
                );
              }),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => License(),
              ),
            );
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
                    builder: (context) => TermsUse(),
                  ),
                );
              }),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => TermsUse(),
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
                    builder: (context) => PrivacyPolicy(),
                  ),
                );
              }),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => PrivacyPolicy(),
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
