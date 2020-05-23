import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:markdown_widget/markdown_widget.dart';
import 'package:markdown_widget/markdown_generator.dart';

class EquipePage extends StatelessWidget {
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
                Text("Quem somos ".toUpperCase(),
                    textScaleFactor: 1.5, style: medTitleStyle),
              ],
            ),
          ),
          Expanded(
            child: Container(
              child: ListView(
                padding: EdgeInsets.zero,
                children: <Widget>[
                  Column(
                    children: [
                      AboutUsText(),
                      Divider(),
                      UesbTextImageSide(),
                      Divider(),
                      UfbaTextImageSide(),
                      Divider(),
                      PmoSocialTextImageSide(),
                      Divider(),
                      // QuemSomosCard(),
                      // Divider(),
                      // UesbCard(),
                      // Divider(),
                      // UfbaCard(),
                      // Divider(),
                      // PmoSocialCard(),
                      // Divider(),
                    ],
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class UesbTextImageSide extends StatelessWidget {
  const UesbTextImageSide({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(left: 20, top: 20, right: 20),
      child: Column(
        children: <Widget>[
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: MarkdownGenerator(
                    data:
                        '**Universidade Estadual do Sudoeste da Bahia (UESB)**',
                    styleConfig:
                        StyleConfig(pConfig: PConfig(selectable: false)))
                .widgets,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                width: 150,
                height: 150,
                child: Image.asset(
                  "assets/images/partners/uesb/logouesb.png",
                  fit: BoxFit.scaleDown,
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(left: 8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: MarkdownGenerator(
                            data:
                                '\n**Dra. Welma Wildes Amorim**\nProfessora de Clínica Médica, Saúde do Idoso e Pesquisadora',
                            styleConfig: StyleConfig(
                                pConfig: PConfig(selectable: false)))
                        .widgets,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class UfbaTextImageSide extends StatelessWidget {
  const UfbaTextImageSide({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(left: 20, top: 20, right: 20),
      child: Column(
        children: <Widget>[
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: MarkdownGenerator(
                    data: '**Universidade Federal da Bahia (UFBA)**',
                    styleConfig:
                        StyleConfig(pConfig: PConfig(selectable: false)))
                .widgets,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                width: 150,
                height: 150,
                child: Image.asset(
                  "assets/images/partners/ufba/ufbalogo.png",
                  fit: BoxFit.scaleDown,
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(left: 8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: MarkdownGenerator(
                            data:
                                '\n**Dr. Marcio Galvão Oliveira**\nProfessor de Farmácia Clínica e Pesquisador\n\n\n**Renato Souza Morais**\nFarmacêutico e Pesquisador Colaborador\n\n\n**Romana Santos Gama**\nFarmacêutica e Pesquisadora Colaborador',
                            styleConfig: StyleConfig(
                                pConfig: PConfig(selectable: false)))
                        .widgets,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class PmoSocialTextImageSide extends StatelessWidget {
  const PmoSocialTextImageSide({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(left: 20, top: 20, right: 20),
      child: Column(
        children: <Widget>[
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: MarkdownGenerator(
                    data:
                        '**Instituto de Gestão de Projetos Sociais (Instituto PMO Social)**',
                    styleConfig:
                        StyleConfig(pConfig: PConfig(selectable: false)))
                .widgets,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                width: 150,
                height: 150,
                child: Image.asset(
                  "assets/images/partners/pmosocial/logo.png",
                  fit: BoxFit.scaleDown,
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(left: 8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: MarkdownGenerator(
                            data:
                                '\n**Wilnara Amorim**\nGerente de Projetos Sociais\n\n\n**Daniel Porto**\nGerente de Projetos de Tecnologia\n\n\n**Diego Porto**\nDesenvolvedor Colaborador',
                            styleConfig: StyleConfig(
                                pConfig: PConfig(selectable: false)))
                        .widgets,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class PmoSocialCard extends StatelessWidget {
  const PmoSocialCard({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.fromLTRB(10, 10, 10, 0),
      height: 300,
      width: double.maxFinite,
      // child: Card(
      //   elevation: 5,
      child: Padding(
        padding: EdgeInsets.all(5),
        child: Stack(children: <Widget>[
          Align(
            alignment: Alignment.center,
            child: Stack(
              children: <Widget>[
                Padding(
                    padding: const EdgeInsets.all(5),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        PmoSocialIcon(),
                        TextCardPmoSocial(),
                      ],
                    ))
              ],
            ),
          )
        ]),
      ),
      // ),
    );
  }
}

class UfbaCard extends StatelessWidget {
  const UfbaCard({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.fromLTRB(10, 10, 10, 0),
      height: 300,
      width: double.maxFinite,
      // child: Card(
      //   elevation: 5,
      child: Padding(
        padding: EdgeInsets.all(5),
        child: Stack(children: <Widget>[
          Align(
            alignment: Alignment.center,
            child: Stack(
              children: <Widget>[
                Padding(
                    padding: const EdgeInsets.all(5),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        UfbaIcon(),
                        TextCardUfba(),
                      ],
                    ))
              ],
            ),
          )
        ]),
      ),
      // ),
    );
  }
}

class UesbCard extends StatelessWidget {
  const UesbCard({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.fromLTRB(10, 10, 10, 0),
      height: 300,
      width: double.maxFinite,
      // child: Card(
      //   elevation: 5,
      child: Padding(
        padding: EdgeInsets.all(5),
        child: Stack(
          children: <Widget>[
            Align(
              alignment: Alignment.center,
              child: Stack(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(5),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        UesbIcon(),
                        TextCardUesb(),
                      ],
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
      // ),
    );
  }
}

class AboutUsText extends StatelessWidget {
  const AboutUsText({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: MarkdownGenerator(
                data:
                    '\n O Aplicativo MPI Brasil foi desenvolvido pelo Instituto de Gestão de Projetos Sociais (**INSTITUTO PMO Social)**, juntamente com a **Universidade Federal da Bahia (UFBA)** por meio do Instituto Multidisciplinar em Saúde-Campus Anísio Teixeira (IMS-CAT/UFBA) e a **Universidade Estadual do Sudoeste da Bahia (UESB)** por meio do Curso de Medicina, Campus de Vitória da Conquista.',
                styleConfig: StyleConfig(pConfig: PConfig(selectable: false)))
            .widgets,
      ),
    );
  }
}

// class QuemSomosCard extends StatelessWidget {
//   const QuemSomosCard({
//     Key key,
//   }) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       padding: EdgeInsets.fromLTRB(10, 10, 10, 0),
//       height: 200,
//       width: double.maxFinite,
//       child: Card(
//         elevation: 5,
//         child: Padding(
//           padding: EdgeInsets.all(5),
//           child: Stack(children: <Widget>[
//             Align(
//               alignment: Alignment.center,
//               child: Stack(
//                 children: <Widget>[
//                   Padding(
//                       padding: const EdgeInsets.all(5),
//                       child: Column(
//                         crossAxisAlignment: CrossAxisAlignment.center,
//                         children: <Widget>[
//                           QuemSomos(),
//                         ],
//                       ))
//                 ],
//               ),
//             )
//           ]),
//         ),
//       ),
//     );
//   }
// }

Widget PmoSocialIcon() {
  return Padding(
    padding: const EdgeInsets.only(bottom: 20.0),
    child: Container(
      alignment: Alignment.center,
      child: Image.asset(
        "assets/images/partners/pmosocial/logo.png",
        width: 300,
        height: 100,
      ),
    ),
  );
}

Widget TextCardPmoSocial() {
  return Container(
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: MarkdownGenerator(
              data:
                  '\n**Wilnara Amorim**\nGerente de Projetos Sociais\n\n\n**Daniel Porto**\nGerente de Projetos de Tecnologia\n\n\n**Diego Porto**\nDesenvolvedor Colaborador',
              styleConfig: StyleConfig(pConfig: PConfig(selectable: false)))
          .widgets,
    ),
  );
}

Widget UfbaIcon() {
  return Padding(
    padding: const EdgeInsets.only(bottom: 20),
    child: Column(
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.only(bottom: 8.0),
          child: Container(
            alignment: Alignment.center,
            child: Image.asset(
              "assets/images/partners/ufba/ufbalogo.png",
              width: 300,
              height: 100,
            ),
          ),
        ),
        Container(
          alignment: Alignment.center,
          child: Text(
            'Universidade Federal da Bahia (UFBA)',
          ),
        ),
      ],
    ),
  );
}

Widget TextCardUfba() {
  return Container(
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
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
                    width: 80,
                    height: 80,
                    child: Image.asset(
                      "assets/images/partners/equipe/marcio.png",
                      fit: BoxFit.contain,
                    ),
                  ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          padding: const EdgeInsets.only(bottom: 8),
                          child: Text(
                            ' Dr. Marcio Galvão Oliveira',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 14,
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
          ],
        ),
      ],
    ),
  );
}

// Widget TextCardUfba() {
//   return Container(
//     child: Column(
//       crossAxisAlignment: CrossAxisAlignment.stretch,
//       children: MarkdownGenerator(
//               data:
//                   '\n**Dr. Marcio Galvão Oliveira**\nProfessor de Farmácia Clínica e Pesquisador\n\n\n**Renato Souza Morais**\nFarmacêutico e Pesquisador Colaborador\n\n\n**Romana Santos Gama**\nFarmacêutica e Pesquisadora Colaborador',
//               styleConfig: StyleConfig(pConfig: PConfig(selectable: false)))
//           .widgets,
//     ),
//   );
// }

Widget UesbIcon() {
  return Padding(
    padding: const EdgeInsets.only(bottom: 20),
    child: Column(
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.only(bottom: 8.0),
          child: Container(
            alignment: Alignment.center,
            child: Image.asset(
              "assets/images/partners/uesb/logouesb.png",
              width: 300,
              height: 100,
            ),
          ),
        ),
        Container(
          alignment: Alignment.center,
          child: Text(
            'Universidade Estadual do Sudoeste da Bahia (UESB)',
          ),
        ),
      ],
    ),
  );
}

Widget TextCardUesb() {
  return Container(
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
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
                    width: 80,
                    height: 80,
                    child: Image.asset(
                      "assets/images/partners/equipe/welma.png",
                      fit: BoxFit.contain,
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(left: 8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: MarkdownGenerator(
                                data:
                                    '\n**Dra. Welma Wildes Amorim**\nProfessora de Clínica Médica, Saúde do Idoso e Pesquisadora',
                                styleConfig: StyleConfig(
                                    pConfig: PConfig(selectable: false)))
                            .widgets,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ],
    ),
  );
}

// Widget QuemSomos() {
//   return Container(
//     child: Column(
//       crossAxisAlignment: CrossAxisAlignment.stretch,
//       children: MarkdownGenerator(
//               data:
//                   '\nO Aplicativo MPI Brasil foi desenvolvido pelo Instituto de Gestão de Projetos Sociais (**INSTITUTO PMO Social)**, juntamente com a **Universidade Federal da Bahia (UFBA)** por meio do Instituto Multidisciplinar em Saúde-Campus Anísio Teixeira (IMS-CAT/UFBA) e a **Universidade Estadual do Sudoeste da Bahia (UESB)** por meio do Curso de Medicina, Campus de Vitória da Conquista.',
//               styleConfig: StyleConfig(pConfig: PConfig(selectable: false)))
//           .widgets,
//     ),
//   );
// }
