import 'package:flutter/material.dart';
import 'package:markdown_widget/markdown_widget.dart';
import '../../constants.dart';

class TermsOfUsePage extends StatelessWidget {
  final headerStyle = TextStyle(
    color: Colors.white,
    fontSize: 24,
    fontWeight: FontWeight.bold,
  );

  final String txtGeneral =
      '\n##### Geral                        \n Estes Termos de Uso se aplicam à utilização do **Aplicativo MPI Brasil**, disponibilizado pelo **Instituto PMO Social** que se destina ao uso por profissionais de saúde. Ao usar o Aplicativo MPI Brasil, você concorda com estes termos. Eles regem o uso do aplicativo e criam um contrato legal vinculativo que podemos aplicar contra você no caso de uma violação. Se você não concorda com todos esses **Termos de Uso**, não use o aplicativo.';
  final String txtRegister =
      '\n##### Registro de conta            \n Você deve registrar uma conta através do **Aplicativo MPI Brasil** para acessar as informações. O registro exige que você nos forneça seu nome, endereço de e-mail, profissão, especialidade e outras informações especificadas no cadastro. Depois insira um nome de usuário e senha que serão associados à sua conta. Você concorda que suas informações de registro são verdadeiras, precisas, atuais e completas e você atualizará prontamente suas informações de registro conforme necessário, para que continuem verdadeiras, precisas, atuais e completas. Podemos tentar verificar a precisão das informações de registro que você forneceu e atualizá-las conforme necessário. Você é o único responsável por manter a confidencialidade e a segurança do nome de usuário e senha da sua conta MPI Brasil e não pode permitir que outra pessoa use seu nome de usuário e senha para acessar o aplicativo. Você é responsável por todas as atividades que ocorrem na sua conta. Se você acredita que a segurança das informações da sua conta foi comprometida, altere imediatamente sua senha através do recurso de configurações da conta ou notifique-nos e nós o ajudaremos. Não nos responsabilizamos por qualquer acesso não autorizado ou uso das informações da sua conta.';
  final String txtAppUse =
      '\n##### Uso do Aplicativo            \n O **Aplicativo MPI Brasil** destina-se a profissionais de saúde. Ao usar o aplicativo, você declara e garante que tem o direito, autoridade e capacidade de concordar e cumprir com estes termos e que não está proibido de usar o aplicativo. \n\n As informações que disponibilizamos através do aplicativo são fornecidas apenas para fins educacionais e informativos. Embora esperemos que você ache as informações úteis para você como profissional de saúde, elas não têm a intenção de servir como um serviço ou plataforma de diagnóstico, para fornecer certeza em relação a um diagnóstico, para recomendar um produto ou tratamento em particular, ou para substituir de outra forma para o julgamento clínico de um profissional de saúde qualificado. Você concorda que não usará as informações com a intenção de criar qualquer tipo de relacionamento médico / paciente, por exemplo, para diagnosticar ou tratar usuários. Você é o único responsável por avaliar as informações obtidas no aplicativo e por seu uso ou uso indevido dessas informações em conexão com suas decisões de tratamento ou de outra forma. Você concorda que será o único responsável por sua conformidade com todas as leis e padrões de prática profissional aplicáveis a você e com a prática de medicina ou outra profissão de saúde. \n\n Não obstante o disposto aqui, você pode estar sujeito a certas obrigações e responsabilidades associadas à jurisdição em que pratica medicina ou outra profissão de saúde. Não fazemos representação ou garantia quanto à conformidade legal do Conteúdo do aplicativo MPI Brasil e você é o único responsável pelo cumprimento das leis de sua jurisdição, com relação ao uso e uso indevido das informações e do Conteúdo do aplicativo MPI Brasil. Reservamo-nos o direito, a qualquer momento, a nosso critério exclusivo, de limitar a disponibilidade e acessibilidade do **Aplicativo MPI Brasil** a qualquer pessoa, área geográfica ou jurisdição que desejamos. \n\n Se você é um usuário que opta por acessar as informações de nível profissional disponibilizadas através do aplicativo, não deve confiar nessas informações como aconselhamento médico profissional ou usar o aplicativo como substituto de qualquer relacionamento com seu médico ou outro profissional de saúde qualificado. Para preocupações com problemas de saúde, incluindo decisões sobre tratamentos, os usuários devem sempre consultar seu médico ou outros profissionais de saúde ou, em casos graves, procurar assistência imediata de equipe médica de emergência. \n\n Sujeito à sua conformidade com estes termos, você recebe uma licença para visualizar as informações disponibilizadas através do aplicativo, exclusivamente para uso pessoal e profissional. Você não deve usar, copiar, adaptar, modificar, preparar trabalhos derivados com base em distribuir, licenciar, vender, transferir, exibir publicamente, executar publicamente, transmitir ou explorar de outra forma as informações e propriedades do aplicativo, exceto conforme expressamente permitido nestes termos. Todos os direitos não concedidos expressamente neste documento são reservados por nós e nossos respectivos licenciadores, conforme o caso. \n\n Você concorda que não se envolverá em nenhuma das seguintes atividades relacionadas ao uso do Aplicativo: \n\n 1. Forjar cabeçalhos ou manipular identificadores para disfarçar a origem de qualquer conteúdo transmitido através do aplicativo; \n\n 2. Usar, exibir, espelhar ou enquadrar em um site o **Aplicativo MPI Brasil**, ou qualquer componente dele, marca comercial, logotipo ou outras informações proprietárias do Instituto PMO Social, sem o consentimento por escrito do Instituto PMO Social, conforme aplicável; \n\n 3. Remover quaisquer avisos de direitos autorais, marcas comerciais ou outros avisos de direitos de propriedade contidos no **Aplicativo MPI Brasil** e qualquer um de seus respectivos licenciadores; \n\n 4. Infringir ou usar qualquer uma de nossas marcas, marcas registradas ou outras marcas de propriedade em qualquer nome comercial, e-mail, URL ou outro contexto, a menos que expressamente aprovado por escrito pelo Instituto PMO Social, conforme aplicável; \n\n 5. Tentar contornar qualquer medida tecnológica de proteção associada ao aplicativo; \n\n 6. Tentar acessar ou pesquisar qualquer conteúdo do aplicativo MPI Brasil através do uso de qualquer mecanismo, software, ferramenta, agente, dispositivo ou mecanismo (incluindo scripts, bots, aranhas, raspadores, rastreadores, ferramentas de mineração de dados ou similares) do que através de software geralmente disponível através de navegadores da web; \n\n 7. Publicar, fazer upload, transmitir ou distribuir cartas em cadeia, esquemas de pirâmide, publicidade ou spam; \n\n 8. Personificar ou deturpar sua afiliação com outra pessoa ou entidade; \n\n 9. Coletar ou coletar informações de outras pessoas, incluindo endereços de e-mail; \n\n 01. Interferir ou interromper o aplicativo ou o computador associado ou sistemas de entrega técnica; \n\n 1. Interferir ou tentar interferir com o acesso de qualquer usuário, host ou rede, incluindo, sem limitação, envio de vírus, sobrecarga, inundação, envio de spam ou envio de bombas por correio eletrônico para um site do MPI Brasil ou o **Aplicativo MPI Brasil**; \n\n 12. Deixar de respeitar a privacidade de outro usuário. Isso inclui revelar a senha, número de telefone, endereço, ID ou endereço de mensagem instantânea de outro usuário ou qualquer outra informação de identificação pessoal; ou\n\n 13. Usar o Conteúdo do **Aplicativo MPI Brasil** de qualquer maneira não permitida por estes termos. \n\n Podemos (mas não somos obrigados a) fazer qualquer uma ou as seguintes ações sem aviso prévio: \n\n 1. Investigar o uso do aplicativo, conforme julgarmos apropriado, para cumprir com qualquer lei, regulamento, solicitação do governo ou processo legal; \n\n 2. Remover Conteúdo do Usuário que acreditamos não estar em conformidade com estes Termos de Uso; \n\n 3. Encerrar seu acesso ao **Aplicativo MPI Brasil** com a nossa determinação de que você violou estes Termos de Uso.';
  final String txtOwnerRights =
      '\n##### Direitos do proprietário     \n Você reconhece e concorda que o **Aplicativo MPI Brasil** contém informações proprietárias e confidenciais protegidas pela propriedade intelectual aplicável e outras leis. Exceto conforme expressamente permitido pela lei aplicável, ou conforme autorizado por nós ou pelo licenciante aplicável, você concorda em não modificar, alugar, arrendar, emprestar, vender, distribuir, transmitir, executar publicamente, criar trabalhos derivados ou "raspar" para comercial ou qualquer outra finalidade, o Aplicativo MPI Brasil, no todo ou em parte. Qualquer uso do Aplicativo MPI Brasil não expressamente permitidos por estes Termos é uma violação destes Termos e pode violar os nossos e de terceiros direitos de propriedade intelectual.';
  final String txtPrivacyPolicy =
      '\n##### Política de Privacidade      \n A Política de Privacidade do **Aplicativo MPI Brasil**, fornece informações sobre nossa coleta, uso e divulgação de informações sobre usuários do aplicativo. Ao acessar e usar o aplicativo, você concorda com os termos da Política de Privacidade e reconhece e concorda que a Política de Privacidade é parte integrante destes termos.';
  final String txtContractLaw =
      '\n##### Leis que regem este Contrato \n Ao acessar o Aplicativo **MPI Brasil**, você concorda que as leis do brasileiras, sem considerar os princípios de escolha de leis, se aplicarão a todos os assuntos relacionados ao uso do aplicativo.';
  final String txtTerminatinAndChanges =
      '\n##### Rescisão e modificação       \n Você concorda que podemos, sob certas circunstâncias e sem aviso prévio, descontinuar, temporariamente ou permanentemente o aplicativo (ou qualquer parte dele), ou eliminar sua conta e remover qualquer informação, com ou sem aviso prévio , por qualquer um dos seguintes motivos (que não se destinam a ser exclusivos): (a) violações ou violações destes termos ou de outros acordos ou diretrizes incorporados, (b) solicitações da aplicação da lei ou de agências governamentais, (c) uma solicitação por você, (d) descontinuação ou modificação do aplicativo (ou de qualquer parte dele), (e) questões ou problemas técnicos ou de segurança, (f) longos períodos de inatividade e / ou (g) seu envolvimento em fraude ou ilegalidade. Você concorda que todas as rescisões por justa causa serão feitas a nosso critério, e não seremos responsáveis perante você ou terceiros por qualquer rescisão da sua conta ou acesso ao aplicativo.';
  final String txtLegalWarning =
      '\n##### Aviso Legal                  \n O APLICATIVO MPI BRASIL, PROPRIEDADES, SERVIÇOS E CONTEÚDO DO APLICATIVO SÃO OFERECIDOS "NO ESTADO EM QUE SE ENCONTRAM", SEM GARANTIA DE QUALQUER TIPO, EXPRESSA OU IMPLÍCITA. NÃO OFERECEMOS GARANTIAS DE QUE A REDE, OS SERVIÇOS OU O CONTEÚDO DO APLICATIVO MPI BRASIL ATENDEM ÀS SUAS EXIGÊNCIAS OU QUE ESTARÃO DISPONÍVEIS COM BASE ININTERRUPTA, SEGURA OU SEM ERROS. NÃO OFERECEMOS GARANTIAS RELATIVAS À PRECISÃO, ATUALIDADE, COMPLETUDE OU CONFIABILIDADE DE QUALQUER CONTEÚDO OBTIDO ATRAVÉS DOS SERVIÇOS. NENHUMA INFORMAÇÃO FORNECIDA ATRAVÉS DOS SERVIÇOS OU POR NÓS, FORMULÁRIO ORAL OU ESCRITO, CRIARÁ QUALQUER GARANTIA NÃO FORNECIDA EXPRESSAMENTE AQUI. SUA CONFIANÇA NO CONTEÚDO OBTIDO OU UTILIZADO POR VOCÊ ATRAVÉS DOS SERVIÇOS É DE SUA CONTA E RISCO. VOCÊ É O ÚNICO RESPONSÁVEL POR TODAS AS SUAS COMUNICAÇÕES E INTERAÇÕES COM OUTROS USUÁRIOS. VOCÊ COMPREENDE QUE NÃO ASSUMIMOS RESPONSABILIDADE POR INSCREVER QUALQUER USUÁRIO NO APLICATIVO MPI BRASIL, NEM VERIFICAMOS OU ASSUMIMOS RESPONSABILIDADE PELO CONTEÚDO DO USUÁRIO. NÃO FORNECEMOS CONSELHOS MÉDICOS E NÃO RECOMENDAMOS OU APROVAMOS PRODUTOS ESPECÍFICOS, USUÁRIOS DE PRODUTOS, TERAPIAS, TESTES, MÉDICOS, PROFISSÕES OU OPINIÕES DE SAÚDE.';
  final String txtResponsability =
      '\n##### Responsabilidade             \n Em nenhum caso, qualquer um de nós ou nossos respectivos diretores, executivos, funcionários, contratados, agentes, patrocinadores, licenciadores ou qualquer outra pessoa ou entidade envolvida na criação, desenvolvimento ou entrega do **Aplicativo MPI Brasil** será responsável por qualquer danos (incluindo, sem limitação a danos acidentais, lesões corporais / morte dolosa, perda de lucros ou danos resultantes de perda de dados ou interrupção dos negócios) decorrentes de / ou relacionados a estes termos ou do uso ou incapacidade de acessar ou uso do **Aplicativo MPI Brasil**, ou de quaisquer comunicações ou interações com outras pessoas com quem você se comunica ou interage como resultado do uso do aplicativo, seja com base na garantia, contrato, ou qualquer outra forma legal e se nós, nossos licenciantes, nossos fornecedores ou terceiros mencionados com o aplicativo, não formos avisados da possibilidade de tais danos. Nós, nossos licenciadores, nossos fornecedores ou terceiros mencionados no aplicativo não somos responsáveis por danos pessoais, incluindo morte, causados pelo uso ou uso indevido do aplicativo ou por qualquer informação fornecida através do aplicativo. Quaisquer reclamações decorrentes do uso do aplicativo devem ser apresentadas dentro de um (1) ano a partir da data do evento que deu origem a tal ação ocorrida. As soluções sob estes termos são exclusivas e estão limitadas expressamente às previstas nestes termos. As limitações dos danos expostos acima são elementos fundamentais da base da nossa relação.';
  final String txt =
      '\n##### Indenização                  \n Você concorda em defender, indenizar e manter cada um de nós e nossos respectivos diretores, funcionários, agentes, licenciadores e fornecedores, inofensivos de e contra quaisquer reivindicações, ações ou demandas, responsabilidades e acordos, incluindo, sem limitação, considerações legais e contábeis razoáveis. taxas resultantes ou alegadamente resultantes do seu acesso ou uso do aplicativo ou da violação destes termos.';
  final String txtChanges =
      '\n##### Modificações                 \n Reservamo-nos o direito, a nosso exclusivo critério, de modificar, descontinuar ou encerrar o **Aplicativo MPI Brasil** ou estes termos, a qualquer momento e sem aviso prévio. Se modificarmos estes termos de maneira material, notificaremos essa modificação no aplicativo. Ao continuar a acessar ou usar os Serviços após a modificação destes termos, você concorda em ficar vinculado aos termos modificados. Se os termos modificados não forem aceitáveis para você, você concorda em parar imediatamente de usar o **Aplicativo MPI Brasil**.';
  final String txtFullContract =
      '\n##### Contrato completo            \n Exceto conforme expressamente previsto em um "aviso legal" específico no site, estes termos (incluindo a Política de Privacidade do MPI Brasil) constituem o contrato completo entre você, Instituto PMO Social e MPI Brasil com relação ao seu uso (e uso anterior) ao **Aplicativo MPI Brasil**. \n\n Estes termos constituem o entendimento e acordo completo e exclusivo entre Instituto PMO Social, MPI Brasil e você em relação ao aplicativo, e estes termos substituem e substituem todos e quaisquer entendimentos ou acordos orais ou escritos anteriores entre a Instituto PMO Social, MPI Brasil e você em relação ao aplicativo.';
  final String txtTask =
      '\n##### Tarefa                       \n Você não pode atribuir ou transferir estes termos, por força de lei ou de outra forma, sem o nosso consentimento prévio por escrito. Qualquer tentativa sua de atribuir ou transferir estes termos, sem esse consentimento, será nula e sem efeito. Podemos atribuir ou transferir estes termos, a nosso critério, sem restrição. Sujeito ao acima exposto, estes termos vincularão e permanecerão em benefício das partes, seus sucessores e cessionários permitidos. Além disso, qualquer um de nós pode exercer os direitos descritos nestes termos.';
  final String txtWarnings =
      '\n##### Avisos                       \n\n Quaisquer notificações ou outras comunicações permitidas ou exigidas neste documento, incluindo as relacionadas a modificações materiais destes termos serão feitas por escrito e fornecidas: (i) por nós por e-mail (em cada caso, para o endereço de e-mail incluído nas suas Informações de Registro); ou (ii) postando no aplicativo. Para avisos feitos por e-mail, a data do recebimento será considerada a data em que o aviso for transmitido.';
  final String txtNoTermination =
      '\n##### Sem renúncia                 \n Nossa falha em fazer cumprir qualquer direito ou disposição destes termos não constituirá uma renúncia à aplicação futura desse direito ou disposição. Exceto conforme expressamente estabelecido nestes termos, o exercício por qualquer uma das partes de seus recursos sob estes termos não prejudicará seus outros recursos sob estes termos ou de outra forma.';
  final String txtSurvive =
      '\n##### Sobrevivência                \n Todas as disposições destes termos continuarão após o encerramento da sua conta do **Aplicativo MPI Brasil**.';
  final String txtContact =
      '\n##### Contate-nos                  \n Se você tiver dúvidas sobre o aplicativo ou estes termos, ou desejar fornecer feedback, entre em contato conosco:  mpibrasil@pmosocial.org, para enviar comentários e sugestões. Desta forma, poderemos melhorar o aplicativo.';

  @override
  Widget build(BuildContext context) {
    final termsOfUse = txtGeneral +
        txtRegister +
        txtAppUse +
        txtOwnerRights +
        txtPrivacyPolicy +
        txtContractLaw +
        txtTerminatinAndChanges +
        txtLegalWarning +
        txtResponsability +
        txt +
        txtChanges +
        txtFullContract +
        txtTask +
        txtWarnings +
        txtNoTermination +
        txtSurvive +
        txtContact;

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
            child: Text('TERMOS DE USO', style: headerStyle),
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
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: MarkdownWidget(
            data: termsOfUse,
            styleConfig: StyleConfig(
              pConfig: PConfig(
                textConfig: TextConfig(textAlign: TextAlign.justify),
              ),
              olConfig: OlConfig(
                indexWidget: (deep, index) {
                  index++;
                  return Container(
                    margin: EdgeInsets.only(left: 5, right: 5),
                    child: Text(
                      index < 10 ? '  $index.' : '$index.',
                    ),
                  );
                },
              ),
            ),
          ),
        ),
      ),
    );
  }
}
