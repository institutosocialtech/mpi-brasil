import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:markdown_widget/markdown_widget.dart';
import 'package:url_launcher/url_launcher.dart';
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
                Text("Equipe ".toUpperCase(),
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
                    '\n O Aplicativo MPI Brasil foi desenvolvido pelo Instituto de Gestão de Projetos Sociais (**Instituto PMO Social)**, juntamente com a **Universidade Federal da Bahia (UFBA)** por meio do Instituto Multidisciplinar em Saúde-Campus Anísio Teixeira (IMS-CAT/UFBA) e a **Universidade Estadual do Sudoeste da Bahia (UESB)** por meio do Curso de Medicina, Campus de Vitória da Conquista.',
                styleConfig: StyleConfig(pConfig: PConfig(selectable: false)))
            .widgets,
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
          GestureDetector(
            onTap: () {
              launch('http://catalogo.uesb.br/cursos/medicina-bac-vc');
            },
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: MarkdownGenerator(
                      data: '**Universidade Estadual do Sudoeste da Bahia**',
                      styleConfig:
                          StyleConfig(pConfig: PConfig(selectable: false)))
                  .widgets,
            ),
          ),
          GestureDetector(
            onTap: () {
              launch('http://catalogo.uesb.br/cursos/medicina-bac-vc');
            },
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: MarkdownGenerator(
                      data: '**(UESB)**',
                      styleConfig:
                          StyleConfig(pConfig: PConfig(selectable: false)))
                  .widgets,
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              GestureDetector(
                onTap: () {
                  launch('http://catalogo.uesb.br/cursos/medicina-bac-vc');
                },
                child: SizedBox(
                  width: 150,
                  height: 150,
                  child: Image.asset(
                    "assets/images/partners/uesb/logo_uesb.png",
                    fit: BoxFit.scaleDown,
                  ),
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(left: 8.0),
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: <Widget>[
                        GestureDetector(
                            onTap: () {
                              launch('http://lattes.cnpq.br/6211832014875307');
                            },
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: MarkdownGenerator(
                                      data:
                                          ' \n**Dra. Welma Wildes Amorim**\nProfessora de Clínica Médica, Saúde do Idoso e Pesquisadora',
                                      styleConfig: StyleConfig(
                                          pConfig: PConfig(selectable: false)))
                                  .widgets,
                            )),
                      ]),
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
          GestureDetector(
            onTap: () {
              launch('http://ims.ufba.br/');
            },
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: MarkdownGenerator(
                      data: '**Universidade Federal da Bahia**',
                      styleConfig:
                          StyleConfig(pConfig: PConfig(selectable: false)))
                  .widgets,
            ),
          ),
          GestureDetector(
            onTap: () {
              launch('http://ims.ufba.br/');
            },
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: MarkdownGenerator(
                      data: '**(UFBA)**',
                      styleConfig:
                          StyleConfig(pConfig: PConfig(selectable: false)))
                  .widgets,
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 8.0),
                child: GestureDetector(
                  onTap: () {
                    launch('http://ims.ufba.br/');
                  },
                  child: SizedBox(
                    width: 120,
                    height: 150,
                    child: Image.asset(
                      "assets/images/partners/ufba/logo_ufba.png",
                      fit: BoxFit.scaleDown,
                    ),
                  ),
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(left: 33.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: <Widget>[
                      GestureDetector(
                        onTap: () {
                          launch('http://lattes.cnpq.br/7413684305204869');
                        },
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: MarkdownGenerator(
                                  data:
                                      '\n**Dr. Marcio Galvão Oliveira**\nProfessor de Farmácia Clínica e Pesquisador',
                                  styleConfig: StyleConfig(
                                      pConfig: PConfig(selectable: false)))
                              .widgets,
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          launch('http://lattes.cnpq.br/3049611000844978');
                        },
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: MarkdownGenerator(
                                  data:
                                      '**Renato Morais Souza**\nFarmacêutico e Pesquisador Colaborador',
                                  styleConfig: StyleConfig(
                                      pConfig: PConfig(selectable: false)))
                              .widgets,
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          launch('http://lattes.cnpq.br/9147688530868098');
                        },
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: MarkdownGenerator(
                                  data:
                                      '**Romana Santos Gama**\nFarmacêutica e Pesquisadora Colaborador',
                                  styleConfig: StyleConfig(
                                      pConfig: PConfig(selectable: false)))
                              .widgets,
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          launch('http://lattes.cnpq.br/0159826112943067');
                        },
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: MarkdownGenerator(
                                  data:
                                      '**Yago Martins**\nEstudante do Curso de Engenharia da Computação e Desenvolvedor Colaborador',
                                  styleConfig: StyleConfig(
                                      pConfig: PConfig(selectable: false)))
                              .widgets,
                        ),
                      ),
                    ],
                    // MarkdownGenerator(
                    //         data:
                    //             '\n**Dr. Marcio Galvão Oliveira**\nProfessor de Farmácia Clínica e Pesquisador\n\n\n**Renato Morais Souza**\nFarmacêutico e Pesquisador Colaborador\n\n\n**Romana Santos Gama**\nFarmacêutica e Pesquisadora Colaborador\n\n\n**Yago Martins**\nDesenvolvedor Colaborador',
                    //         styleConfig: StyleConfig(
                    //             pConfig: PConfig(selectable: false)))
                    //     .widgets,
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
          GestureDetector(
            onTap: () {
              launch('http://www.pmosocial.org/');
            },
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: MarkdownGenerator(
                      data: '**Instituto de Gestão de Projetos Sociais**\n',
                      styleConfig:
                          StyleConfig(pConfig: PConfig(selectable: false)))
                  .widgets,
            ),
          ),
          GestureDetector(
            onTap: () {
              launch('http://www.pmosocial.org/');
            },
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: MarkdownGenerator(
                      data: '**(Instituto PMO Social)**',
                      styleConfig:
                          StyleConfig(pConfig: PConfig(selectable: false)))
                  .widgets,
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              GestureDetector(
                onTap: () {
                  launch('http://www.pmosocial.org/');
                },
                child: SizedBox(
                  width: 150,
                  height: 150,
                  child: Image.asset(
                    "assets/images/partners/pmosocial/logo_pmosocial.png",
                    fit: BoxFit.scaleDown,
                  ),
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(left: 8.0),
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: <Widget>[
                        GestureDetector(
                          onTap: () {
                            launch(
                                'https://www.linkedin.com/in/wilnara-amorim');
                          },
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: MarkdownGenerator(
                                    data:
                                        '\n**Wilnara Amorim**\nGerente de Projetos Sociais',
                                    styleConfig: StyleConfig(
                                        pConfig: PConfig(selectable: false)))
                                .widgets,
                          ),
                        ),

                        GestureDetector(
                          onTap: () {
                            launch(
                                'https://sites.google.com/site/danielporto/');
                          },
                          child: Padding(
                            padding: const EdgeInsets.only(left:10.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: MarkdownGenerator(
                                      data:
                                          '**Daniel Porto**\nGerente de Projetos de Tecnologia',
                                      styleConfig: StyleConfig(
                                          pConfig: PConfig(selectable: false)))
                                  .widgets,
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            launch('http://github.com/diego-ch');
                          },
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: MarkdownGenerator(
                                    data:
                                        '**Diego Porto**\nDesenvolvedor Colaborador',
                                    styleConfig: StyleConfig(
                                        pConfig: PConfig(selectable: false)))
                                .widgets,
                          ),
                        ),
                        // MarkdownGenerator(
                        //         data:
                        //             '\n**Wilnara Amorim**\nGerente de Projetos Sociais\n\n\n**Daniel Porto**\nGerente de Projetos de Tecnologia\n\n\n**Diego Porto**\nDesenvolvedor Colaborador',
                        //         styleConfig: StyleConfig(
                        //             pConfig: PConfig(selectable: false)))
                        //     .widgets,
                      ]),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

// class PmoSocialCard extends StatelessWidget {
//   const PmoSocialCard({
//     Key key,
//   }) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       padding: EdgeInsets.fromLTRB(10, 10, 10, 0),
//       height: 300,
//       width: double.maxFinite,
//       // child: Card(
//       //   elevation: 5,
//       child: Padding(
//         padding: EdgeInsets.all(5),
//         child: Stack(children: <Widget>[
//           Align(
//             alignment: Alignment.center,
//             child: Stack(
//               children: <Widget>[
//                 Padding(
//                     padding: const EdgeInsets.all(5),
//                     child: Column(
//                       crossAxisAlignment: CrossAxisAlignment.center,
//                       children: <Widget>[
//                         PmoSocialIcon(),
//                         TextCardPmoSocial(),
//                       ],
//                     ))
//               ],
//             ),
//           )
//         ]),
//       ),
//       // ),
//     );
//   }
// }

// class UfbaCard extends StatelessWidget {
//   const UfbaCard({
//     Key key,
//   }) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       padding: EdgeInsets.fromLTRB(10, 10, 10, 0),
//       height: 300,
//       width: double.maxFinite,
//       // child: Card(
//       //   elevation: 5,
//       child: Padding(
//         padding: EdgeInsets.all(5),
//         child: Stack(children: <Widget>[
//           Align(
//             alignment: Alignment.center,
//             child: Stack(
//               children: <Widget>[
//                 Padding(
//                     padding: const EdgeInsets.all(5),
//                     child: Column(
//                       crossAxisAlignment: CrossAxisAlignment.center,
//                       children: <Widget>[
//                         UfbaIcon(),
//                         TextCardUfba(),
//                       ],
//                     ))
//               ],
//             ),
//           )
//         ]),
//       ),
//       // ),
//     );
//   }
// }

// class UesbCard extends StatelessWidget {
//   const UesbCard({
//     Key key,
//   }) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       padding: EdgeInsets.fromLTRB(10, 10, 10, 0),
//       height: 300,
//       width: double.maxFinite,
//       // child: Card(
//       //   elevation: 5,
//       child: Padding(
//         padding: EdgeInsets.all(5),
//         child: Stack(
//           children: <Widget>[
//             Align(
//               alignment: Alignment.center,
//               child: Stack(
//                 children: <Widget>[
//                   Padding(
//                     padding: const EdgeInsets.all(5),
//                     child: Column(
//                       crossAxisAlignment: CrossAxisAlignment.center,
//                       children: <Widget>[
//                         UesbIcon(),
//                         TextCardUesb(),
//                       ],
//                     ),
//                   )
//                 ],
//               ),
//             )
//           ],
//         ),
//       ),
//       // ),
//     );
//   }
// }

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

// Widget PmoSocialIcon() {
//   return Padding(
//     padding: const EdgeInsets.only(bottom: 20.0),
//     child: Container(
//       alignment: Alignment.center,
//       child: Image.asset(
//         "assets/images/partners/pmosocial/logo_pmosocial.png",
//         width: 300,
//         height: 100,
//       ),
//     ),
//   );
// }

// Widget TextCardPmoSocial() {
//   return Container(
//     child: Column(
//       crossAxisAlignment: CrossAxisAlignment.stretch,
//       children: MarkdownGenerator(
//               data:
//                   '\n**Wilnara Amorim**\nGerente de Projetos Sociais\n\n\n**Daniel Porto**\nGerente de Projetos de Tecnologia\n\n\n**Diego Porto**\nDesenvolvedor Colaborador',
//               styleConfig: StyleConfig(pConfig: PConfig(selectable: false)))
//           .widgets,
//     ),
//   );
// }

// Widget UfbaIcon() {
//   return Padding(
//     padding: const EdgeInsets.only(bottom: 20),
//     child: Column(
//       children: <Widget>[
//         Padding(
//           padding: const EdgeInsets.only(bottom: 8.0),
//           child: Container(
//             alignment: Alignment.center,
//             child: Image.asset(
//               "assets/images/partners/ufba/logo_ufba.png",
//               width: 300,
//               height: 100,
//             ),
//           ),
//         ),
//         Container(
//           alignment: Alignment.center,
//           child: Text(
//             'Universidade Federal da Bahia (UFBA)',
//           ),
//         ),
//       ],
//     ),
//   );
// }

// Widget TextCardUfba() {
//   return Container(
//     child: Column(
//       crossAxisAlignment: CrossAxisAlignment.stretch,
//       children: <Widget>[
//         Column(
//           children: [
//             Container(
//               padding: EdgeInsets.only(left: 20, top: 20, right: 20),
//               child: Row(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 crossAxisAlignment: CrossAxisAlignment.center,
//                 children: [
//                   SizedBox(
//                     width: 80,
//                     height: 80,
//                     child: Image.asset(
//                       "assets/images/partners/equipe/marcio.png",
//                       fit: BoxFit.contain,
//                     ),
//                   ),
//                   Expanded(
//                     child: Column(
//                       crossAxisAlignment: CrossAxisAlignment.center,
//                       children: [
//                         Container(
//                           padding: const EdgeInsets.only(bottom: 8),
//                           child: Text(
//                             ' Dr. Marcio Galvão Oliveira',
//                             style: TextStyle(
//                               fontWeight: FontWeight.bold,
//                               fontSize: 14,
//                             ),
//                             textAlign: TextAlign.justify,
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ],
//         ),
//       ],
//     ),
//   );
// }

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

// Widget UesbIcon() {
//   return Padding(
//     padding: const EdgeInsets.only(bottom: 20),
//     child: Column(
//       children: <Widget>[
//         Padding(
//           padding: const EdgeInsets.only(bottom: 8.0),
//           child: Container(
//             alignment: Alignment.center,
//             child: Image.asset(
//               "assets/images/partners/uesb/logouesb.png",
//               width: 300,
//               height: 100,
//             ),
//           ),
//         ),
//         Container(
//           alignment: Alignment.center,
//           child: Text(
//             'Universidade Estadual do Sudoeste da Bahia (UESB)',
//           ),
//         ),
//       ],
//     ),
//   );
// }

// Widget TextCardUesb() {
//   return Container(
//     child: Column(
//       crossAxisAlignment: CrossAxisAlignment.stretch,
//       children: <Widget>[
//         Column(
//           children: [
//             Container(
//               padding: EdgeInsets.only(left: 20, top: 20, right: 20),
//               child: Row(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 crossAxisAlignment: CrossAxisAlignment.center,
//                 children: [
//                   SizedBox(
//                     width: 80,
//                     height: 80,
//                     child: Image.asset(
//                       "assets/images/partners/equipe/welma.png",
//                       fit: BoxFit.contain,
//                     ),
//                   ),
//                   Expanded(
//                     child: Padding(
//                       padding: const EdgeInsets.only(left: 8.0),
//                       child: Column(
//                         crossAxisAlignment: CrossAxisAlignment.stretch,
//                         children: MarkdownGenerator(
//                                 data:
//                                     '\n**Dra. Welma Wildes Amorim**\nProfessora de Clínica Médica, Saúde do Idoso e Pesquisadora',
//                                 styleConfig: StyleConfig(
//                                     pConfig: PConfig(selectable: false)))
//                             .widgets,
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ],
//         ),
//       ],
//     ),
//   );
// }

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
