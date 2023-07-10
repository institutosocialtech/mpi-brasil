import 'package:flutter/material.dart';
import 'package:mpibrasil/constants.dart';
import 'package:mpibrasil/models/http_exception.dart';
import 'package:mpibrasil/providers/auth.dart';
import 'package:mpibrasil/screens/common/splashscreen.dart';
import 'package:provider/provider.dart';

class DeleteAccount extends StatelessWidget {
  const DeleteAccount({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: kColorMPIWhite,
      body: SingleChildScrollView(
        child: Container(
          height: deviceSize.height,
          width: deviceSize.width,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Flexible(
                flex: deviceSize.width > 600 ? 3 : 2,
                child: DeleteAccountCard(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class DeleteAccountCard extends StatefulWidget {
  const DeleteAccountCard({Key key}) : super(key: key);

  @override
  State<DeleteAccountCard> createState() => _DeleteAccountCardState();
}

class _DeleteAccountCardState extends State<DeleteAccountCard> {
  var _isLoading = false;
  var email;

  void _showErrorDialog(String message) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("Erro"),
        content: Container(
          margin: EdgeInsets.only(top: 10),
          child: Text(message),
        ),
        actions: <Widget>[
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: Text("OK"),
          ),
        ],
      ),
    );
  }

  Future<void> _deleteAccount(bool hasConfirmedAccountDeletion) async {
    if (!hasConfirmedAccountDeletion) return;

    // display progress indicator
    setState(() => _isLoading = true);

    try {
      // delete user account
      await Provider.of<Auth>(context, listen: false).deleteAccount();

      // display success message
      await showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text("MPI Brasil"),
          content: Container(
            margin: EdgeInsets.only(top: 10),
            child: Text(
                'A sua conta foi excluída com sucesso! Para usar o app novamente, faça um novo cadastro!'),
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text("OK"),
            ),
          ],
        ),
      );

      Navigator.pop(context);
      Navigator.pushReplacementNamed(context, '/');

      // register logout
      await Provider.of<Auth>(context, listen: false).logout();
    } on HttpException catch (error) {
      String errorMessage;

      switch (error.toString()) {
        case 'INVALID_ID_TOKEN':
          errorMessage =
              'Credenciais não são mais válidas. Por favor efetue login novamente';
          break;

        case 'MISSING_ID_TOKEN':
          errorMessage = 'Credenciais inválidas!';
          break;

        case 'USER_NOT_FOUND':
          errorMessage =
              'Não há registros associados a esse identificador. Usuário pode ter sido excluído!';
          break;

        default:
          errorMessage = 'Falha ao tentar excluir conta!';
      }

      _showErrorDialog(errorMessage);
    } catch (error) {
      final errorMessage = 'Erro desconhecido: ${error.message}';
      _showErrorDialog(errorMessage);
    }

    // hide progress indicator
    setState(() => _isLoading = false);
  }

  @override
  Widget build(BuildContext context) {
    final String messageTitle = 'Exclusão de Conta';
    final String messageBody =
        'Observe que a confirmação dessa ação resultará na exclusão permanente da sua conta e todos os dados associados a ela.';
    final String messageFooter =
        'Caso não queira prosseguir com a exclusão da conta, clique no botão voltar.';

    final bodyTextStyle = TextStyle(
      color: kColorMPIGray,
      fontSize: 20,
      fontWeight: FontWeight.normal,
    );

    final titleTextStyle = TextStyle(
      color: kColorMPIGray,
      fontSize: 22,
      fontWeight: FontWeight.bold,
    );

    return Container(
      padding: EdgeInsets.all(35.0),
      child: _isLoading
          ? Center(
              child: CircularProgressIndicator(
                backgroundColor: kColorMPIWhite,
                valueColor: AlwaysStoppedAnimation<Color>(kColorMPIGreen),
              ),
            )
          : Column(
              children: [
                // page title
                Padding(
                  padding: EdgeInsets.only(bottom: 10.0, top: 50.0),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text(messageTitle, style: titleTextStyle),
                  ),
                ),

                // page body
                Padding(
                  padding: const EdgeInsets.only(bottom: 10.0),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text(messageBody, style: bodyTextStyle),
                  ),
                ),

                Padding(
                  padding: const EdgeInsets.only(bottom: 25.0),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text(messageFooter, style: bodyTextStyle),
                  ),
                ),

                Expanded(
                  child: Container(),
                ),

                // action buttons
                Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    ElevatedButton(
                      onPressed: () => Navigator.of(context).pop(),
                      child: Text('Voltar'),
                      style: ElevatedButton.styleFrom(
                        foregroundColor: kColorMPIWhite,
                      ),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        _showConfirmDeleteDialog(context);
                      },
                      child: Text('Excluir Conta'.toUpperCase()),
                      style: ElevatedButton.styleFrom(
                        foregroundColor: kColorMPIWhite,
                        backgroundColor: kColorMPIRed,
                      ),
                    ),
                  ],
                )
              ],
            ),
    );
  }

  Future<void> _showConfirmDeleteDialog(BuildContext context) async {
    bool hasConfirmedAccountDeletion = await showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return AlertDialog(
          title: Text('Confirmar Exclusão de Conta'),
          content: Text(
              'Deseja realmente excluir a sua conta do MPI Brasil? Esta ação não poderá ser desfeita!'),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(false),
              child: Text('Voltar'),
            ),
            TextButton(
              onPressed: () => Navigator.of(context).pop(true),
              child: Text('Excluir Conta'),
              style: TextButton.styleFrom(foregroundColor: kColorMPIRed),
            ),
          ],
        );
      },
    );

    _deleteAccount(hasConfirmedAccountDeletion);
  }
}
