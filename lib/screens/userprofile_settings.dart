import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:intl/intl.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:mpibrasil/constants.dart';
import 'package:provider/provider.dart';
import '../providers/auth.dart';
import '../providers/userpreferences.dart';

class ProfileSettings extends StatefulWidget {
  @override
  _ProfileSettingsState createState() => _ProfileSettingsState();
}

class _ProfileSettingsState extends State<ProfileSettings> {
  var _isInit = true;
  var _isLoading = false;

  @override
  void didChangeDependencies() {
    if (_isInit) {
      setState(() => _isLoading = true);

      Provider.of<UserPreferences>(context, listen: false)
          .fetchUserData()
          .then((_) => setState(() => _isLoading = false));
    }
    _isInit = false;
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Perfil do usuário'),
      ),
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        child: _isLoading
            ? Center(
                child: CircularProgressIndicator(
                  backgroundColor: kColorMPIWhite,
                  valueColor: AlwaysStoppedAnimation<Color>(kColorMPIGreen),
                ),
              )
            : Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  drawSettingsCard(context),
                  ElevatedButton(
                    child: Text('Sair'),
                    onPressed: () {
                      Navigator.pop(context);
                      Navigator.pushReplacementNamed(context, '/');
                      Provider.of<Auth>(context, listen: false).logout();
                    },
                    style: ElevatedButton.styleFrom(primary: kColorMPIGreen),
                  ),
                ],
              ),
      ),
    );
  }

  Widget drawSettingsCard(BuildContext context) {
    var userData = Provider.of<UserPreferences>(context, listen: false);
    var user = userData.user;

    return Card(
      elevation: 5,
      margin: EdgeInsets.all(10),
      child: Column(
        children: <Widget>[
          // user name
          ListTile(
            title: Text('Nome'),
            subtitle: Text(user.name),
            leading: Icon(AntDesign.user, color: kColorMPIGreen),
            trailing: IconButton(
              icon: Icon(AntDesign.edit),
              onPressed: () => _showEditNameDialog(context, user.name),
            ),
          ),

          // user email
          ListTile(
            enabled: false,
            title: Text('Email'),
            subtitle: Text('mpibrasil@pmosocial.org'),
            leading: Icon(AntDesign.mail, color: kColorMPIGreen),
            trailing: IconButton(
              icon: Icon(AntDesign.edit),
              onPressed: () => print("edit email"),
            ),
          ),

          // user password
          ListTile(
            enabled: false,
            title: Text('Senha'),
            subtitle: Text('********'),
            leading: Icon(AntDesign.key, color: kColorMPIGreen),
            trailing: IconButton(
              icon: Icon(AntDesign.edit),
              onPressed: () => print("edit password"),
            ),
          ),

          // user birthDate
          ListTile(
            title: Text('Data de Nascimento'),
            subtitle: Text(
              _dateToString(user.birthDate),
            ),
            leading: Icon(AntDesign.calendar, color: kColorMPIGreen),
            trailing: IconButton(
              icon: Icon(AntDesign.edit),
              onPressed: () => _showEditBirthDateDialog(
                context,
                _dateToString(user.birthDate),
              ),
            ),
          ),

          // user occupation
          ListTile(
            title: Text('Ocupação'),
            subtitle: Text(_occupationToString(user.occupation)),
            leading: Icon(AntDesign.rest, color: kColorMPIGreen),
            trailing: IconButton(
              icon: Icon(AntDesign.edit),
              onPressed: () =>
                  _showEditOccupationDialog(context, user.occupation),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _showEditNameDialog(
      BuildContext context, String initialValue) async {
    final deviceSize = MediaQuery.of(context).size;

    var update = await showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        // fill current user data
        var controller = TextEditingController();
        controller.text = initialValue;

        // build dialog
        return AlertDialog(
          title: Text("Editar"),
          content: Container(
            width: deviceSize.width * 0.85,
            margin: EdgeInsets.symmetric(vertical: 20),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                TextField(
                  controller: controller,
                  decoration: InputDecoration(
                    hintText: 'Digite seu Nome',
                    labelText: 'Nome',
                    border: OutlineInputBorder(),
                    contentPadding: EdgeInsets.symmetric(horizontal: 10),
                  ),
                ),
              ],
            ),
          ),
          actions: <Widget>[
            // cancel action
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text("Cancelar"),
              style: TextButton.styleFrom(
                primary: kColorMPIGreen,
              ),
            ),

            // save action
            TextButton(
              onPressed: () => Navigator.of(context).pop(controller.text),
              child: Text("Salvar"),
              style: TextButton.styleFrom(
                primary: kColorMPIWhite,
                backgroundColor: kColorMPIGreen,
              ),
            ),
          ],
        );
      },
    );

    if (update != null) {
      Provider.of<UserPreferences>(context, listen: false)
          .updateUserData(name: update);
    }
  }

  Future<void> _showEditBirthDateDialog(
      BuildContext context, String initialValue) async {
    final deviceSize = MediaQuery.of(context).size;

    var update = await showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        // fill current user data
        var controller = TextEditingController();
        controller.text = initialValue;

        // build dialog
        return AlertDialog(
          title: Text("Editar"),
          content: Container(
            width: deviceSize.width * 0.85,
            margin: EdgeInsets.symmetric(vertical: 20),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                TextField(
                  controller: controller,
                  inputFormatters: [
                    new MaskTextInputFormatter(
                      mask: '##/##/####',
                      filter: {"#": RegExp(r'[0-9]')},
                    ),
                  ],
                  decoration: InputDecoration(
                    hintText: 'DD/MM/YYYY',
                    labelText: 'Data de Nascimento',
                    border: OutlineInputBorder(),
                    contentPadding: EdgeInsets.symmetric(horizontal: 10),
                  ),
                ),
              ],
            ),
          ),
          actions: <Widget>[
            // cancel action
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text("Cancelar"),
              style: TextButton.styleFrom(
                primary: kColorMPIGreen,
              ),
            ),

            // save action
            TextButton(
              onPressed: () => Navigator.of(context).pop(
                DateFormat('dd/MM/yyyy').parse(controller.text),
              ),
              child: Text("Salvar"),
              style: TextButton.styleFrom(
                primary: kColorMPIWhite,
                backgroundColor: kColorMPIGreen,
              ),
            ),
          ],
        );
      },
    );

    if (update != null) {
      Provider.of<UserPreferences>(context, listen: false)
          .updateUserData(birthDate: update);
    }
  }

  Future<void> _showEditOccupationDialog(
      BuildContext context, String initialValue) async {
    final deviceSize = MediaQuery.of(context).size;

    var update = await showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        var selected;

        // build dialog
        return AlertDialog(
          title: Text("Escolha sua ocupação:"),
          content: Container(
            width: deviceSize.width * 0.75,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                // TODO: fix radio button group
                // RadioButtonGroup(
                //   labels: [
                //     'Médico(a)',
                //     'Enfermeiro(a)',
                //     'Farmacêutico(a)',
                //     'Estudante',
                //     'Outros'
                //   ],
                //   activeColor: kColorMPIGreen,
                //   onSelected: (value) {
                //     switch (value) {
                //       case 'Médico(a)':
                //         selected = 'medico';
                //         break;
                //       case 'Enfermeiro(a)':
                //         selected = 'enfermeiro';
                //         break;
                //       case 'Farmacêutico(a)':
                //         selected = 'farmaceutico';
                //         break;
                //       case 'Estudante':
                //         selected = 'estudante';
                //         break;
                //       case 'Outros':
                //         selected = 'outros';
                //     }
                //   },
                // ),
              ],
            ),
          ),
          actions: <Widget>[
            // cancel action
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text("Cancelar"),
              style: TextButton.styleFrom(primary: kColorMPIGreenOpaque),
            ),

            // save action
            TextButton(
              onPressed: () => Navigator.of(context).pop(selected),
              child: Text("Salvar"),
              style: TextButton.styleFrom(
                primary: kColorMPIWhite,
                backgroundColor: kColorMPIGreen,
              ),
            ),
          ],
        );
      },
    );

    if (update != null) {
      Provider.of<UserPreferences>(context, listen: false)
          .updateUserData(occupation: update);
    }
  }

  String _dateToString(DateTime date) {
    return '${date.day}/${date.month}/${date.year}';
  }

  String _occupationToString(String occupation) {
    switch (occupation) {
      case 'medico':
        return 'Médico(a)';
      case 'enfermeiro':
        return 'Enfermeiro(a)';
      case 'farmaceutico':
        return 'Farmacêutico(a)';
      case 'estudante':
        return 'Estudante';
      case 'outros':
        return 'Outros';
      default:
        return 'Não Identificado';
    }
  }
}
