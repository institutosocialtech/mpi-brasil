class QuestionsFaq {
  QuestionsFaq(this.title, this.subtitle);

  final String title;
  final String subtitle;
}

final List<QuestionsFaq> data = [
  QuestionsFaq('O que é Medicamentos Inapropriados para Idosos (MPI)?',
      'Um medicamento é considerado potencialmente inapropriado para idosos quando apresenta um risco significativo de evento adverso na evidência de alternativa igual ou mais efetiva e com menor risco para tratar a mesma condição.'),
  QuestionsFaq('O que são as Reações Adversas a Medicamentos (RAM)?',
      "Na assistência clínica ao paciente idoso, é importante ficar atento ao uso de medicamentos, pois as Reações Adversas a Medicamentos (RAM) é a forma mais comum de latrogenia nos idosos.\n Muitos fármacos comumente prescritos levam a RAM potencialmente ameaçadoras a vida ou incapacitantes."),
  QuestionsFaq('Como prescrever um medicamento apropriado?',
      'A escolha do medicamento apropriado para cada doença em particular é um processo complexo, pois é essencial que a prescrição seja clinicamente efetiva, segura e tenha uma relação de custo=benefício satisfatória.'),
  QuestionsFaq(
      'O que é o Consenso Brasileiro de Medicamentos Potencialmente Inapropriados para Idosos?',
      'É um instrumento para detecção de MPI adaptados à realidade brasileira, divide estes medicamentos em 2 classes: \n MPI independente de condição clínica \n MPI a depender de condição clínica'),
  QuestionsFaq('O App é Open Source?', 'O App MPI Brasil foi desenvolvido ...'),
  QuestionsFaq('Como posso contribuir?', 'Conteúdo: \n Sugerir Informação \n Sugerir Correção \n Adicionar Medicamento \n Outras Informações fale conosco por e-mail\n\n Aplicação: \n Acesse nosso GitHub,'),
];
