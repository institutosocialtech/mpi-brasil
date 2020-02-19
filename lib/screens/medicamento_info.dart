import 'package:flutter/material.dart';

class MedicamentoInfo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: getListView(),
    );
  }

  Widget getListView() {
    var listView = ListView(
      children: <Widget>[
        Container(
          child: ListTile(
            title: Text(
              "Acebutolol",
              textScaleFactor: 1.4,
            ),
            subtitle: Text("Antiarritimico e Anti-hipertensivo"),
          ),
          color: Color.fromRGBO(254, 254, 252, 1),
          padding: EdgeInsets.all(10),
        ),
        getBar(),
        ListTile(
          title: Text(
              "O Lorem padrão usado por estas indústrias desde o ano de 1500, quando uma misturou os caracteres de um texto para criar um espécime de livro. Este texto não só sobreviveu 5 séculos, mas também o salto para a tipografia electrónica, mantendo-se essencialmente inalterada. Foi popularizada nos anos 60 com a disponibilização das folhas de Letraset, que continham passagens com Lorem Ipsum, e mais recentemente com os programas de publicação como o Aldus PageMaker que incluem versões do Lorem Ipsum."),
        ),
        ListTile(
          title: Text(
            "MPI independete de condição clínica",
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          subtitle: Text("SIM"),
        ),
        ListTile(
          title: Text(
            "Classe Farmacológica",
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          subtitle: Text(
              "Beta-bloqueadores com atividade simpática e para-simpática"),
        ),
      ],
    );

    return listView;
  }
}

Widget getBar() {
  var bar = Container(
    child: Row(
      children: const <Widget>[
        Padding(
          padding: EdgeInsets.all(10.0),
          child: IconButton(
              icon: Icon(Icons.star),
              color: Colors.amberAccent,
              iconSize: 20,
              onPressed: null),
        ),
        Padding(
          padding: EdgeInsets.all(10.0),
          child: IconButton(
              icon: Icon(Icons.share), iconSize: 20, onPressed: null),
        ),
        Padding(
          padding: EdgeInsets.all(10.0),
          child: IconButton(
              icon: Icon(Icons.info_outline), iconSize: 20, onPressed: null),
        ),
        Padding(
          padding: EdgeInsets.all(10.0),
          child: IconButton(
              icon: Icon(Icons.format_size), iconSize: 20, onPressed: null),
        ),
      ],
    ),
    color: Color.fromRGBO(248, 249, 251, 1),
    padding: EdgeInsets.all(10),
  );

  return bar;
}
