import 'dart:ui';
import 'package:flutter/material.dart';
// import 'package:url_launcher/url_launcher.dart';

class FAQ extends StatelessWidget {
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
                Text("FAQ", textScaleFactor: 1.5, style: medTitleStyle),
              ],
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemBuilder: (BuildContext context, int index) {
                return new StuffInTiles(listOfTiles[index]);
              },
              itemCount: listOfTiles.length,
            ),
          ),
        ],
      ),
    );
  }
}

class StuffInTiles extends StatelessWidget {
  final MyTile myTile;
  StuffInTiles(this.myTile);

  @override
  Widget build(BuildContext context) {
    return _buildTiles(myTile);
  }

  Widget _buildTiles(MyTile t) {
    List<Widget> monitorTiles = [];
    if (t.children.isEmpty) {
      return new ListTile(
          dense: true,
          // enabled: true,
          isThreeLine: false,
          onLongPress: () => print("long press"),
          onTap: () => print("tap"),
          // subtitle: new Text("Subtitle"),
          // leading: new Text("Leading"),
          selected: false,
          // trailing: new Text("trailing"),
          title: new Text(t.title));
    }
    for (MyTile item in t.children) {
      monitorTiles.add(
        Padding(
          padding: EdgeInsets.fromLTRB(10, 0, 10, 5),
          child: Card(elevation: 5, child: MonitorCard(item)),
        ),
      );
    }
    return new ExpansionTile(
      key: new PageStorageKey<int>(3),
      title: new Text(
        t.title,
        style: TextStyle(
          fontWeight: FontWeight.bold,
        ),
      ),
      children: <Widget>[
        Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: monitorTiles,
          // children: t.children.map(_buildTiles).toList(),
        ),
      ],
    );
  }
}

class MyTile {
  String title;
  List<MyTile> children;
  MyTile(this.title, [this.children = const <MyTile>[]]);
}

List<MyTile> listOfTiles = <MyTile>[
  new MyTile(
    'O que são Medicamentos Inapropriados para Idosos (MPI)?',
    <MyTile>[
      new MyTile(
          'Um medicamento é considerado potencialmente inapropriado para idosos quando apresenta um risco significativo de evento adverso na evidência de alternativa igual ou mais efetiva e com menor risco para tratar a mesma condição.'),
    ],
  ),
  new MyTile(
    'O que são as Reações Adversas a Medicamentos (RAM)?',
    <MyTile>[
      new MyTile(
          "Na assistência clínica ao paciente idoso, é importante ficar atento ao uso de medicamentos, pois as Reações Adversas a Medicamentos (RAM) é a forma mais comum de latrogenia nos idosos.\n Muitos fármacos comumente prescritos levam a RAM potencialmente ameaçadoras a vida ou incapacitantes."),
    ],
  ),
  new MyTile(
    'Como prescrever um medicamento apropriado?',
    <MyTile>[
      new MyTile(
          'A escolha do medicamento apropriado para cada doença em particular é um processo complexo, pois é essencial que a prescrição seja clinicamente efetiva, segura e tenha uma relação de custo=benefício satisfatória.'),
    ],
  ),
  new MyTile(
    'O que é o Consenso Brasileiro de Medicamentos Potencialmente Inapropriados para Idosos?',
    <MyTile>[
      new MyTile(
          'É um instrumento para detecção de MPI adaptados à realidade brasileira, divide estes medicamentos em 2 classes: \n MPI independente de condição clínica \n MPI a depender de condição clínica'),
    ],
  ),
  new MyTile(
    'O App é Código Aberto?',
    <MyTile>[
      new MyTile('O App MPI Brasil foi desenvolvido ...'),
    ],
  ),
  new MyTile(
    'Como posso contribuir?',
    <MyTile>[
      new MyTile(
          'Conteúdo: \n Sugerir Informação \n Sugerir Correção \n Adicionar Medicamento \n Outras Informações fale conosco por e-mail\n\n Aplicação: \n Acesse nosso GitHub,'),
    ],
  ),
];

class MonitorCard extends StatelessWidget {
  final MyTile item;

  MonitorCard(
    this.item,
  );

  @override
  Widget build(BuildContext context) {
    var widgets = List<Widget>();

    widgets.add(Text(
      item.title,
      textAlign: TextAlign.justify,
    ));

    return Padding(
        padding: EdgeInsets.all(20), child: Column(children: widgets));
  }
}
