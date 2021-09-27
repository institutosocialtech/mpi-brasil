import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:markdown_widget/markdown_widget.dart';

import '../constants.dart';

class PrivacyPolicyPage extends StatelessWidget {
  final headerStyle = TextStyle(
    color: Colors.white,
    fontSize: 24,
    fontWeight: FontWeight.bold,
  );

  final String txtGeneral =
      '\n##### Geral                                              \n Esta Política de Privacidade descreve as práticas de privacidade do Instituto PMO Social em relação ao uso do Aplicativo MPI Brasil destinado a profissionais de saúde. \n\n Disponibilizamos o Aplicativo MPI Brasil como um recurso informativo, destinado a apoiar os profissionais de saúde em seus esforços para fornecer assistência de qualidade aos pacientes. Se você optar por usar o aplicativo, deverá concordar com os Termos de Uso do Instituto PMO Social, que representa um contrato entre nós e os usuários do aplicativo. Ao concordar com os Termos de Uso do Instituto PMO Social, você confirma que leu e entendeu esta Política de Privacidade, que explica como coletamos, divulgamos, transferimos, protegemos e usamos informações sobre você em conexão com o uso do aplicativo, com os direitos e escolhas que você tem sobre essas atividades. \n\n Se você não deseja que coletemos e utilizemos informações sobre você, conforme descrito nesta Política de Privacidade, não deverá usar o aplicativo. Ao usar o aplicativo, você reconhece que armazenaremos, usaremos e processaremos suas informações no Brasil e em qualquer outro país a partir do qual é aplicável o trabalho do Instituto PMO Social. Esteja ciente de que as leis e os padrões de privacidade em alguns países podem diferir daqueles que se aplicam no país em que você reside. A menos que especificado de outra forma aqui, o Instituto PMO Social e parceiros são os controladores das informações pessoais que coletamos sobre você, conforme descrito nesta Política de Privacidade. \n';
  final String txtInformationCollected =
      '\n##### Informações coletadas                              \n As informações sobre o uso do aplicativo são coletadas da seguinte forma: \n - **Cadastro.** Para usar os Serviços, pode ser necessário que você registre uma conta e forneça certas informações pessoais, como nome, endereço de e-mail, código postal, profissão, ocupação, especialidade e, dependendo do seu país de atuação, seu número de registro profissional ou equivalente. Você pode optar por atualizar ou complementar as informações pessoais que você forneceu no registro a qualquer momento, através das configurações da sua conta ou entrando em contato. \n\n - **Informações sobre o aplicativo.** Coletamos e armazenamos automaticamente informações sobre o uso do aplicativo, como seu envolvimento com conteúdo específico, independentemente de você ter aberto um e-mail específico, clicado em um link, suas consultas de pesquisa e com que frequência e quando você se envolve com o aplicativo. Também coletamos informações sobre o seu dispositivo quando você acessa o aplicativo, incluindo endereço IP, informações do navegador (incluindo URL de referência), informações sobre cookies e ID de publicidade (que é um número de identificação exclusivo e redefinível pelo usuário para publicidade associada a um dispositivo móvel). Utilizamos cookies e outras tecnologias de rastreamento, como pixels, tags, sinalizadores da web e kits de desenvolvimento de software, para coletar informações sobre o uso do aplicativo e do seu dispositivo. \n\n - **Pesquisa de mercado.** Você pode ser convidado a participar de pesquisas realizadas por nós ou em nosso nome para nossos próprios fins de melhoria do aplicativo e também pesquisas de mercado realizadas por ou em nome de parceiros. Em algumas pesquisas, pode ser solicitado que você forneça informações pessoais para contato (por exemplo, por e-mail ou telefone). \n\n - **Formulários de Informações e Registro.** Periodicamente, podemos oferecer a você a oportunidade de receber informações ou serviços adicionais nossos ou de terceiros, incluindo nossos anunciantes (por exemplo, solicitação de amostra, visita ao representante de vendas, marketing direto etc.) ou para se registrar para participar de eventos ao vivo, pessoalmente ou via transmissão ao vivo. Se você desejar participar de tais oportunidades, pode ser solicitado que você forneça informações pessoais para atender à solicitação. Salvo indicação em contrário no formulário de solicitação, podemos usar as informações descritas nesta Política de Privacidade e terceiros, se aplicável, serão obrigados a usar essas informações pessoais, conforme descrito no ponto de coleta. \n\n - **Informações de fontes de terceiros.** Podemos obter informações adicionais sobre você de fontes de terceiros para nos ajudar a fornecer os Serviços. Por exemplo, podemos usar informações de terceiros para verificar e atualizar suas informações de registro, para fins de pesquisa ou para personalizar os Serviços, incluindo publicidade. \n\n - **Usuários não registrados.** Você deve se registrar no Aplicativo MPI Brasil para acessar todas informações. As informações que coletamos incluem o site de referência, se aplicável, o tipo de navegador que você usa, o material visualizado e a hora e data em que você acessou o aplicativo. \n';
  final String txtInformationUsed =
      '\n##### Como suas informações podem ser usadas             \n As informações sobre você podem ser usadas para os seguintes fins: \n\n - **Prestação dos Serviços.** Podemos usar as informações coletadas sobre você para fornecer e melhorar o aplicativo e desenvolver novos recursos. \n\n - **Perfis de membros.** Podemos associar as informações que coletamos sobre o uso do aplicativo às suas informações de registro e qualquer outra informação que tenhamos sobre você, conforme descrito nesta Política de Privacidade, criando assim um perfil seu que podemos atualizar periodicamente (" Perfil do Membro ").\n\n - **Comunicações.** Ao se registrar como usuário no Aplicativo MPI Brasil, você concorda com o uso de suas informações de registro e outras informações coletadas sobre você, conforme descrito nesta Política de Privacidade, para se comunicar com você sobre o aplicativo e outras informações que podem lhe interessar. Essas comunicações podem ser transmitidas por diversos canais, sujeitos à lei aplicável, incluindo e-mails e podem conter anúncios e outros materiais promocionais de patrocinadores de terceiros. \n\n - **Personalize os serviços, incluindo publicidade.** Podemos personalizar o aplicativo, incluindo a publicidade que você vê, em sites de terceiros e em nossas comunicações por email, com base nas informações incluídas no seu Perfil de Membro. \n\n - **Objetivos da verificação.** Podemos usar suas informações em conjunto com informações de terceiros para reconhecê-lo como membro registrado quando você visitar o aplicativo e verificar sua identidade e / ou credenciais profissionais. Podemos exigir que você forneça prova de sua identidade, inclusive que você é um profissional de saúde e, se não puder fazer isso com satisfação razoável, reservamo-nos o direito de negar o acesso ao aplicativo. Embora tomemos medidas para verificar se nossos membros que se identificam como profissionais de saúde são realmente profissionais de saúde, não garantimos sua identidade, credenciais profissionais ou status de licenciamento. \n\n - **Gerenciamento de contas.** Podemos usar suas informações para administrar sua conta, responder às suas perguntas, atender suas solicitações e enviar comunicações administrativas sobre o aplicativo. \n\n - **Investigações.** Podemos usar suas informações para detectar, investigar e nos defender contra atividades fraudulentas ou ilegais, violações dos Termos de Uso do aplicativo MPI Brasil e para estabelecer, exercer e defender nossos direitos legais. \n';
  final String txtSharingInformationThirdParties =
      '\n##### Compartilhando suas informações com terceiros      \n As informações sobre o uso do aplicativo podem ser compartilhadas da seguinte maneira: \n\n - **Provedores de serviço.** Trabalhamos com prestadores de serviços terceirizados para nos ajudar a fornecer os Serviços e, de outra forma, nos auxiliar na operação do Aplicativo MPI Brasil, incluindo nas áreas de gerenciamento e implantação de e-mails, análises, marketing, publicidade, pesquisa de mercado, sorteios e administração de concursos, validação de identidade e credencial profissional, distribuição de conteúdo, atendimento ao cliente, atendimento de pagamentos, logística de eventos, manutenção de sites e armazenamento e segurança de dados. Podemos fornecer a esses prestadores de serviços informações pessoais sobre os usuários de nossos Serviços, para que eles possam cumprir suas responsabilidades conosco; no entanto, exigimos que eles concordem em limitar o uso dessas informações pessoais ao cumprimento dessas responsabilidades. \n\n - **Publicidade e programas patrocinados.** Podemos fornecer suas informações pessoais a patrocinadores terceirizados de anúncios e programas patrocinados, sujeitos à lei aplicável. Especificamente, quando você for exposto a um anúncio por meio dos Serviços, em um de nossos sites ou aplicativos, em um e-mail ou por outros meios, ou quando você se envolver em um Programa Patrocinado, por exemplo, acessar um recurso de informação patrocinado, abrir um de nossos e-mails patrocinados, o Instituto PMO Social pode fornecer suas informações pessoais, como seu nome e especialidade (mas não seu e-mail ou endereço postal) ao patrocinador aplicável e / ou seus agentes em nome do patrocinador. Também podemos fornecer a esses terceiros detalhes sobre seu envolvimento com o anúncio ou o Programa patrocinado (por exemplo, se você visualizou ou interagiu com determinado conteúdo), suas respostas a quaisquer perguntas contidas no Programa patrocinado e informações sobre você que recebemos de terceiros. \n\n - **Perfis de usuários.** Sujeito à lei aplicável, o Instituto PMO Social pode fornecer Perfis de usuários e partes dele (excluindo informações de contato) a terceiros, incluindo nossos clientes de publicidade, que esses terceiros podem usar para seus negócios fins, incluindo marketing. \n\n - **Pesquisa de mercado.** Determinadas oportunidades de pesquisa de mercado exigem que a empresa de pesquisa de mercado entre em contato diretamente com você para realizar a pesquisa, inclusive por telefone. No convite da pesquisa, informaremos você se for necessário fornecer informações de contato adicionais, por exemplo, número de telefone, para que você possa decidir naquele momento se deseja continuar com a oportunidade. Não divulgamos as respostas da sua pesquisa ao patrocinador de uma maneira que o identifique. \n\n - **Relatório de eventos adversos.** Se você nos fornece informações sobre um evento adverso referente a um produto farmacêutico, poderemos ser obrigados a relatar essas informações juntamente com suas informações de contato ao fabricante, conforme necessário para cumprir suas obrigações de relatório à autoridade reguladora aplicável. Se você não deseja que essas informações sejam relatadas ao fabricante e à autoridade reguladora aplicáveis, não nos forneça informações sobre eventos adversos. \n\n **Consentimento.** Podemos divulgar suas informações pessoais a terceiros de uma maneira não abordada por esta Política de Privacidade, sujeita ao seu consentimento nesse momento. \n';
  final String txtInformationSecurity =
      '\n##### Segurança da Informação                            \n - Implementamos medidas de segurança técnica e organizacional apropriadas para proteger as informações pessoais que temos sob nosso controle contra acesso não autorizado, uso, divulgação e perda acidental. Quando você insere informações pessoais, criptografamos a transmissão dessas informações ou usamos a tecnologia de conexões SSL (Secure Socket Layer). Você é o único responsável por manter a segurança e a confidencialidade do nome de usuário e senha da sua conta. Infelizmente, nenhum método de transmissão pela Internet ou método de armazenamento eletrônico é totalmente seguro. Portanto, embora nos esforcemos para proteger suas informações pessoais, não podemos garantir sua segurança absoluta. \n';
  final String txtChoiceControl =
      '\n##### Escolha e controle                                 \n - **Informação da conta.** Você pode atualizar suas informações de registro a qualquer momento através do cadastro disponível em configurações. Você também pode entrar em contato em mpibrasil@pmosocial.org e solicitar que suas informações de registro sejam atualizadas ou excluídas. Observe que, se excluirmos sua conta, poderemos manter certas informações sem identificação sobre você para fins comerciais internos, incluindo pesquisa, análise e relatórios. \n\n - **Desativação de dispositivos móveis.** Você pode controlar a publicidade baseada em interesses no seu dispositivo móvel, ativando a configuração "Limitar o rastreamento de anúncios" nas configurações do seu dispositivo iOS ou "Desativar a personalização de anúncios" nas configurações do seu dispositivo Android. Isso não impedirá que você veja anúncios, mas limitará o uso de identificadores de publicidade no dispositivo para personalizar anúncios com base em seus interesses. Você também pode desativar a transmissão de informações precisas de localização através das configurações do seu dispositivo. \n\n - **Comunicações por email.** Determinadas comunicações por e-mail que enviamos aos usuários estão relacionadas ao Aplicativo MPI Brasil, desde que você seja usuário deste aplicativo, você não poderá cancelar a inscrição nesse e-mail. \n\n';
  final String txtUsersBrazil =
      '\n##### Nota para usuários fora do Brasil                  \n - O Instituto PMO Social está localizado no Brasil, como a maioria da infraestrutura técnica do Aplicativo MPI Brasil, incluindo suas instalações de hospedagem de dados. Para fornecer os Serviços a você, provavelmente transferiremos suas informações pessoais para fora do seu país de residência, inclusive para o Brasil, onde serão armazenadas e processadas de acordo com esta Política de Privacidade. Podemos transferir suas informações fora do Brasil para prestadores de serviços com operações em outros países. Ao utilizar o Aplicativo MPI Brasil, você concorda com essa coleta, armazenamento e processamento no Brasil e em outros lugares, embora o Brasil e outras jurisdições possam não oferecer o mesmo nível de proteção de dados considerado adequado em seu próprio país. Tomaremos medidas razoáveis para proteger suas informações pessoais. Observe que suas informações pessoais podem estar disponíveis para o governo brasileiro ou suas agências em processo legal realizado no Brasil. \n\n';
  final String txtChildPrivacy =
      '\n##### Privacidade das crianças                           \n O Instituto PMO Social, por meio do Aplicativo MPI Brasil que foi desenvolvido para uso por adultos, e não se destinam nem são usados por crianças menores de 18 anos. Não coletamos informações pessoais de pessoas que sabemos que são menores de 18 anos. \n\n';
  final String txtChangesPrivacyPolicy =
      '\n##### Alterações na Política de Privacidade              \n Reservamo-nos o direito de modificar esta Política de Privacidade a qualquer momento e quaisquer alterações entrarão em vigor após a publicação da Política de Privacidade modificada, a menos que o avisemos do contrário. Se fizermos alterações materiais nesta Política de Privacidade, notificaremos você por e-mail (enviado para o endereço de e-mail incluído no perfil da sua conta) e / ou por meio de um aviso em nossos sites antes da efetivação da alteração. Recomendamos que você reveja periodicamente esta Política de Privacidade para obter as informações mais recentes sobre nossas práticas de privacidade. Ao continuar a usar o Aplicativo MPI Brasil após as alterações feitas nesta Política de Privacidade, você concorda com essas alterações. \n\n';
  final String txtContact =
      '\n##### Como entrar em contato                             \n Se você tiver dúvidas gerais sobre sua conta ou esta Política de Privacidade, entre em **mpibrasil@pmosocial.org** \n\n';
  @override
  Widget build(BuildContext context) {
    final privacyPolicy = txtGeneral +
        txtInformationCollected +
        txtInformationUsed +
        txtSharingInformationThirdParties +
        txtInformationSecurity +
        txtChoiceControl +
        txtUsersBrazil +
        txtChildPrivacy +
        txtChangesPrivacyPolicy +
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
            child: Text('POLÍTICA DE PRIVACIDADE', style: headerStyle),
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
            data: privacyPolicy,
            styleConfig: StyleConfig(
                pConfig: PConfig(
                  selectable: false,
                  textConfig: TextConfig(textAlign: TextAlign.justify),
                ),
                olConfig: OlConfig(
                  indexWidget: (deep, index) {
                    index++;
                    return Container(
                      margin: EdgeInsets.symmetric(horizontal: 20),
                      child: Text(index < 10 ? '  $index.' : '$index.'),
                    );
                  },
                )),
          ),
        ),
      ),
    );
  }
}
