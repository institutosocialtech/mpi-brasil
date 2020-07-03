import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:provider/provider.dart';

import '../providers/userpreferences.dart';
import '../widgets/topbar.dart';

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

      Provider.of<UserPreferences>(context)
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
                  backgroundColor: Colors.white,
                  valueColor: AlwaysStoppedAnimation<Color>(Colors.green),
                ),
              )
            : Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  drawSettingsCard(context),
                  RaisedButton(
                    child: Text('Sair'),
                    color: Colors.black54,
                    textColor: Colors.white,
                    onPressed: () => print("Sair"),
                  ),
                ],
              ),
      ),
    );
  }

  Widget drawSettingsCard(BuildContext context) {
    var userData = Provider.of<UserPreferences>(context);
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
            leading: Icon(AntDesign.user, color: Colors.green),
            trailing: IconButton(
              icon: Icon(AntDesign.edit),
              onPressed: () => showEditNameDialog(context, user.name),
            ),
          ),

          // user email
          ListTile(
            title: Text('Email'),
            subtitle: Text('email@example.com'),
            leading: Icon(AntDesign.mail, color: Colors.green),
            trailing: IconButton(
              icon: Icon(AntDesign.edit),
              onPressed: () => print("edit birthDate"),
            ),
          ),

          // user birthDate
          ListTile(
            title: Text('Data de Nascimento'),
            subtitle: Text(
              _dateToString(user.birthDate),
            ),
            leading: Icon(AntDesign.calendar, color: Colors.green),
            trailing: IconButton(
              icon: Icon(AntDesign.edit),
              onPressed: () => print("edit birthDate"),
            ),
          ),

          // user occupation
          ListTile(
            title: Text('Ocupação'),
            subtitle: Text(user.occupation != null ? user.occupation : ''),
            leading: Icon(AntDesign.rest, color: Colors.green),
            trailing: IconButton(
              icon: Icon(AntDesign.edit),
              onPressed: () => print("edit occupation"),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> showEditNameDialog(
      BuildContext context, String initialValue) async {
    await showDialog(
      context: context,
      builder: (context) {
        // fill current user data
        var controller = TextEditingController();
        controller.text = initialValue;

        // build dialog
        return AlertDialog(
          title: Text("Editar Nome"),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              TextField(
                controller: controller,
                decoration: InputDecoration(
                  hintText: 'Digite seu Nome',
                  border: OutlineInputBorder(),
                  contentPadding: EdgeInsets.symmetric(horizontal: 10),
                ),
              ),
            ],
          ),
          actions: <Widget>[
            // cancel action
            FlatButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text("Cancelar", style: TextStyle(color: Colors.green)),
            ),

            // save action
            FlatButton(
              color: Colors.green,
              onPressed: () => Navigator.of(context).pop(),
              child: Text("Salvar", style: TextStyle(color: Colors.white)),
            ),
          ],
        );
      },
    );
  }

  String _dateToString(DateTime date) {
    return '${date.day}/${date.month}/${date.year}';
  }
}
