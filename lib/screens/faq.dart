import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:markdown_widget/markdown_widget.dart';

class FAQPage extends StatelessWidget {
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
                Text("FAQ", textScaleFactor: 1.5, style: medTitleStyle),
              ],
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemBuilder: (BuildContext context, int index) {
                return new StuffInTiles(listOfQuestions[index]);
              },
              itemCount: listOfQuestions.length,
            ),
          ),
        ],
      ),
    );
  }
}

class StuffInTiles extends StatelessWidget {
  final ItemFaq questionsAndAnswer;
  StuffInTiles(this.questionsAndAnswer);

  @override
  Widget build(BuildContext context) {
    return _buildTiles(questionsAndAnswer);
  }

  Widget _buildTiles(ItemFaq t) {
    List<Widget> monitorTiles = [];
    if (t.answer.isEmpty) {
      return new ListTile(
          dense: true,
          isThreeLine: false,
          selected: false,
          title: new Text(t.question));
    }
    for (ItemFaq item in t.answer) {
      monitorTiles.add(Padding(
        padding: EdgeInsets.fromLTRB(10, 0, 10, 5),
        child: Card(
          elevation: 5,
          child: Padding(
            padding: EdgeInsets.all(20),
            child: Column(
              children: MarkdownGenerator(
                      data: item.question,
                      styleConfig:
                          StyleConfig(pConfig: PConfig(selectable: false)))
                  .widgets,
            ),
          ),
        ),
      ));
    }
    return new ExpansionTile(
      key: new PageStorageKey<int>(3),
      title: new Text(
        t.question,
        style: TextStyle(
          fontWeight: FontWeight.bold,
        ),
      ),
      children: <Widget>[
        Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: monitorTiles,
        ),
      ],
    );
  }
}

class ItemFaq {
  String question;
  List<ItemFaq> answer;
  ItemFaq(this.question, [this.answer = const <ItemFaq>[]]);
}

List<ItemFaq> listOfQuestions = <ItemFaq>[
  new ItemFaq(
    'Como podemos definir uma prescrição inapropriada?',
    <ItemFaq>[
      new ItemFaq(
          ' Uma prescrição inapropriada abrange o uso de medicamentos que apresentam um risco significativo de evento adverso, quando há evidência de alternativa igual ou mais efetiva e com menor risco para tratar a mesma condição.'),
    ],
  ),
  new ItemFaq(
    'Como prescrever um medicamento apropriado?',
    <ItemFaq>[
      new ItemFaq(
          " A escolha do medicamento apropriado para cada doença em particular é um processo complexo, pois é essencial que a prescrição seja clinicamente efetiva, segura e tenha uma relação de custo-benefício satisfatória. É necessário contrabalancear a experiência clínica do prescritor e as melhores evidências científicas."),
    ],
  ),
  new ItemFaq(
    'O que é o Consenso Brasileiro de Medicamentos Potencialmente Inapropriados para idosos?',
    <ItemFaq>[
      new ItemFaq(
          ' É um instrumento para detecção de MPI adaptados à realidade brasileira, que divide estes medicamentos em dois grupos:\n\n   - MPI independente de condição clínica.\n   - MPI a depender de condição clínica.\n\n Foi elaborado através da Técnica Delphi com especialistas nacionais, utilizando como referências principais duas listas internacionais de MPI.'),
    ],
  ),
  new ItemFaq(
    'O que são as Reações Adversas a Medicamentos (RAMs)?',
    <ItemFaq>[
      new ItemFaq(
          " Reação adversa a medicamento é uma resposta nociva e não intencional e que ocorre em doses normalmente utilizadas no homem, para profilaxia, diagnóstico ou tratamento de uma doença ou para modificações de funções fisiológicas. Na assistência ao paciente idoso, é importante ficar atento ao uso de medicamentos, pois muitos fármacos comumente prescritos levam à RAMs potencialmente ameaçadoras à vida ou incapacitantes."),
    ],
  ),
  new ItemFaq(
    'O que é polifarmácia?',
    <ItemFaq>[
      new ItemFaq(
          ' Não há um consenso na literatura, no entanto, a polifarmácia é frequentemente definida como o uso rotineiro de cinco ou mais medicamentos. Alguns autores se referem a polifarmácia como o uso de um número de medicamentos maior do que o clinicamente indicado.'),
    ],
  ),
  new ItemFaq(
    'O que é desprescrição?',
    <ItemFaq>[
      new ItemFaq(
          ' A desprescrição é o processo de redução gradual, interrupção, descontinuação ou retirada de medicamentos, com o objetivo de gerenciar a polifarmácia e melhorar os resultados'),
    ],
  ),
  new ItemFaq(
    'Como posso acessar o código?',
    <ItemFaq>[
      new ItemFaq(
          ' O App MPI Brasil é disponibilizado no repositório do GitHub, e foi desenvolvido sob a Licença MIT . Esta licença de código aberto segue incluída no repositório e permite que outras pessoas usem, contribuam, alterem e distribuam livremente o código do aplicativo MPI Brasil. Para obter mais informações sobre esta licença MIT, acesse: https://github.com/pmosocial/mpi-brasil/blob/master/LICENSE'),
    ],
  ),
  new ItemFaq(
    'Como posso contribuir com a informação?',
    <ItemFaq>[
      new ItemFaq(
          ' Sugerindo correções, adicionando medicamentos, informando erros e outras informações. Contacte-nos pelo email **mpibrasil@pmosocial.org**'),
    ],
  ),
  new ItemFaq(
    "Como posso contribuir com a aplicação?",
    <ItemFaq>[
      new ItemFaq(
          " Através do repositório do projeto disponível em: https://github.com/pmosocial/mpi-brasil"),
    ],
  ),
  new ItemFaq(
    "Quais as Instituições envolvidas no desenvolvimento do aplicativo MPI Brasil?",
    <ItemFaq>[
      new ItemFaq(
          " Este aplicativo (segunda versão) foi desenvolvido  pelo Instituto de Gestão de Projetos Sociais (Instituto PMO Social), juntamente com a Universidade Federal da Bahia (UFBA), por meio do Instituto Multidisciplinar em Saúde- Campus Anísio Teixeira (IMS-CAT/UFBA) e pela Universidade Estadual do Sudoeste da Bahia (UESB), por meio do Curso de Medicina, Campus de Vitória da Conquista."),
    ],
  ),
  // new ItemFaq(
  //   "",
  //   <ItemFaq>[
  //     new ItemFaq(
  //         ""),
  //   ],
  // ),
];
