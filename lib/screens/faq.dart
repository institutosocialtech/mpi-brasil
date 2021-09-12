import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:markdown_widget/markdown_widget.dart';
import 'package:url_launcher/url_launcher.dart';

import '../constants.dart';

class FAQ {
  String question;
  String answer;

  FAQ(this.question, this.answer);
}

class FAQPage extends StatelessWidget {
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
            child: Text('FAQ', style: headerStyle),
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
        child: Expanded(
          child: FAQList(),
        ),
      ),
    );
  }
}

class FAQList extends StatelessWidget {
  // static faq list
  final List<FAQ> faqList = [
    new FAQ(
      'Como podemos definir uma prescrição inapropriada?',
      'Uma prescrição inapropriada abrange o uso de medicamentos que apresentam um risco significativo de evento adverso, quando há evidência de alternativa igual ou mais efetiva e com menor risco para tratar a mesma condição.',
    ),
    new FAQ(
      'Como prescrever um medicamento apropriado?',
      'A escolha do medicamento apropriado para cada doença em particular é um processo complexo, pois é essencial que a prescrição seja clinicamente efetiva, segura e tenha uma relação de custo-benefício satisfatória. É necessário contrabalancear a experiência clínica do prescritor e as melhores evidências científicas.',
    ),
    new FAQ(
      'O que é o Consenso Brasileiro de Medicamentos Potencialmente Inapropriados para idosos?',
      'É um instrumento para detecção de MPI adaptados à realidade brasileira, que divide estes medicamentos em dois grupos:\n\n- MPI independente de condição clínica.\n- MPI a depender de condição clínica.\n\nFoi elaborado através da Técnica Delphi com especialistas nacionais, utilizando como referências principais duas listas internacionais de MPI.',
    ),
    new FAQ(
      'O que são as Reações Adversas a Medicamentos (RAMs)?',
      'Reação adversa a medicamento é uma resposta nociva e não intencional e que ocorre em doses normalmente utilizadas no homem, para profilaxia, diagnóstico ou tratamento de uma doença ou para modificações de funções fisiológicas. Na assistência ao paciente idoso, é importante ficar atento ao uso de medicamentos, pois muitos fármacos comumente prescritos levam à RAMs potencialmente ameaçadoras à vida ou incapacitantes.',
    ),
    new FAQ(
      'O que é polifarmácia?',
      'Não há um consenso na literatura, no entanto, a polifarmácia é frequentemente definida como o uso rotineiro de cinco ou mais medicamentos. Alguns autores se referem a polifarmácia como o uso de um número de medicamentos maior do que o clinicamente indicado.',
    ),
    new FAQ(
      'O que é desprescrição?',
      'A desprescrição é o processo de redução gradual, interrupção, descontinuação ou retirada de medicamentos, com o objetivo de gerenciar a polifarmácia e melhorar os resultados',
    ),
    new FAQ(
      'Como posso contribuir com a informação?',
      'Sugerindo correções, adicionando medicamentos, informando erros e outras informações.\n\nContacte-nos pelo email: [mpibrasil@pmosocial.org](mailto:mpibrasil@pmosocial.org)',
    ),
    new FAQ('Como posso acessar o código?',
        'O App MPI Brasil é disponibilizado no repositório do GitHub, e foi desenvolvido sob a Licença MIT. Esta licença de código aberto segue incluída no repositório e permite que outras pessoas usem, contribuam, alterem e distribuam livremente o código do aplicativo MPI Brasil. Para obter mais informações sobre esta licença, acesse:\n\nhttps://github.com/pmosocial/mpi-brasil/blob/master/LICENSE'),
    new FAQ(
      'Como posso contribuir com a aplicação?',
      'Através do repositório do projeto disponível em: https://github.com/pmosocial/mpi-brasil',
    ),
    new FAQ(
        'Quais as Instituições envolvidas no desenvolvimento do aplicativo MPI Brasil?',
        'Este aplicativo (segunda versão) foi desenvolvido  pelo **Instituto de Gestão de Projetos Sociais** (Instituto PMO Social), juntamente com a **Universidade Federal da Bahia** (UFBA), por meio do Instituto Multidisciplinar em Saúde - Campus Anísio Teixeira (IMS-CAT/UFBA) e pela **Universidade Estadual do Sudoeste da Bahia** (UESB), por meio do Curso de Medicina, Campus de Vitória da Conquista.'),
  ];

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      itemCount: faqList.length,
      separatorBuilder: (BuildContext context, int index) =>
          Divider(color: kColorMPIDividerGray),
      itemBuilder: (BuildContext context, index) {
        var faq = faqList[index];

        // draw expansion tile
        return ExpansionTile(
          title: Text(
            faq.question,
            textAlign: TextAlign.left,
            style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.bold,
            ),
          ),

          // draw answer
          children: <Widget>[
            Padding(
              padding: EdgeInsets.fromLTRB(20, 10, 20, 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: MarkdownGenerator(
                  data: faq.answer,
                  styleConfig: StyleConfig(
                    pConfig: PConfig(
                      selectable: false,
                      textStyle: TextStyle(color: kColorTextLightGray),
                      textConfig: TextConfig(textAlign: TextAlign.justify),
                      linkStyle: TextStyle(
                        color: Colors.green,
                        fontWeight: FontWeight.bold,
                      ),
                      onLinkTap: (link) => launch(link),
                    ),
                  ),
                ).widgets,
              ),
            ),
          ],
        );
      },
    );
  }
}
