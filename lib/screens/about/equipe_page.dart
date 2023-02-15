import 'package:flutter/material.dart';
import 'package:markdown_widget/markdown_widget.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../constants.dart';

class EquipePage extends StatelessWidget {
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
            child: Text('EQUIPE', style: headerStyle),
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
              ],
            )
          ],
        ),
      ),
    );
  }
}

class AboutUsText extends StatelessWidget {
  const AboutUsText({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var aboutText =
        'A equipe do projeto MPI Brasil é formada pelos colaboradores da UESB, ' +
            'da UFBA e do Instituto SocialTech.';

    return Container(
      padding: EdgeInsets.only(left: 20, top: 20, bottom: 0, right: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: MarkdownGenerator(
          data: aboutText,
          styleConfig: StyleConfig(
            pConfig: PConfig(
              textConfig: TextConfig(textAlign: TextAlign.justify),
            ),
          ),
        ).widgets,
      ),
    );
  }
}

class UesbTextImageSide extends StatelessWidget {
  const UesbTextImageSide({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(left: 20, top: 0, right: 20),
      child: Column(
        children: <Widget>[
          GestureDetector(
            onTap: () {
              launch('http://catalogo.uesb.br/cursos/medicina-bac-vc');
            },
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: MarkdownGenerator(
                      data:
                          '**Universidade Estadual do Sudoeste da Bahia (UESB)**')
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
                child: Center(
                  child: SizedBox(
                    width: 150,
                    height: 150,
                    child: Image.asset(
                      "assets/images/partners/uesb/logo_uesb.png",
                      fit: BoxFit.scaleDown,
                    ),
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
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: MarkdownGenerator(
                              data:
                                  '**Dra. Welma Wildes Amorim**\nProfessora de Clínica Médica, Saúde do Idoso e Pesquisadora',
                            ).widgets,
                          ),
                        ),
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
  const UfbaTextImageSide({Key key}) : super(key: key);

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
                data: '**Universidade Federal da Bahia (UFBA)**',
              ).widgets,
            ),
          ),
          GestureDetector(
            onTap: () {
              launch('http://ims.ufba.br/');
            },
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: MarkdownGenerator(
                data:
                    'Instituto Multidisciplinar em Saúde\nCampus Anísio Teixeira (IMS-CAT/UFBA)',
                styleConfig: StyleConfig(
                  pConfig: PConfig(
                    textConfig: TextConfig(textAlign: TextAlign.center),
                  ),
                ),
              ).widgets,
            ),
          ),
          SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 7.0),
                child: GestureDetector(
                  onTap: () {
                    launch('http://ims.ufba.br/');
                  },
                  child: SizedBox(
                    width: 120,
                    height: 150,
                    child: Image.asset(
                      "assets/images/partners/ufba/logo_ufba.png",
                      fit: BoxFit.fitHeight,
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
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: MarkdownGenerator(
                            data:
                                '**Dr. Marcio Galvão Oliveira**\nProfessor de Farmácia Clínica e Pesquisador',
                          ).widgets,
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          launch('http://lattes.cnpq.br/3049611000844978');
                        },
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: MarkdownGenerator(
                            data:
                                '**Renato Morais Souza**\nFarmacêutico e Pesquisador Colaborador',
                          ).widgets,
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          launch('http://lattes.cnpq.br/9147688530868098');
                        },
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: MarkdownGenerator(
                            data:
                                '**Romana Santos Gama**\nFarmacêutica e Pesquisadora Colaborador',
                          ).widgets,
                        ),
                      ),
                    ],
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
  const PmoSocialTextImageSide({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(left: 20, top: 20, right: 20),
      child: Column(
        children: <Widget>[
          GestureDetector(
            onTap: () {
              launch('http://www.socialtech.org.br/');
            },
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: MarkdownGenerator(
                data: '**Instituto de Gestão de Projetos Sociais**\n',
              ).widgets,
            ),
          ),
          GestureDetector(
            onTap: () {
              launch('http://www.socialtech.org.br/');
            },
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: MarkdownGenerator(
                data: '**(SocialTech)**',
              ).widgets,
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
                    launch('http://www.socialtech.org.br/');
                  },
                  child: SizedBox(
                    width: 120,
                    height: 150,
                    child: Image.asset(
                      "assets/images/partners/socialtech/logo_socialtech.png",
                      fit: BoxFit.scaleDown,
                    ),
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
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: MarkdownGenerator(
                              data:
                                  '**Wilnara Amorim**\nGerente de Projetos Sociais',
                            ).widgets,
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            launch(
                                'https://sites.google.com/site/danielporto/');
                          },
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: MarkdownGenerator(
                              data:
                                  '**Dr. Daniel Porto**\nPesquisador e Gerente de Tecnologia',
                            ).widgets,
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            launch('http://github.com/diego-ch');
                          },
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: MarkdownGenerator(
                              data:
                                  '**Diego Porto**\nDesenvolvedor Colaborador',
                            ).widgets,
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            launch('http://github.com/diego-ch');
                          },
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: MarkdownGenerator(
                              data:
                                  '**Fernando Neves**\n UX/UI Designer Colaborador',
                            ).widgets,
                          ),
                        ),
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
