import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:intl/intl.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:provider/provider.dart';
import '../providers/userpreferences.dart';

class UserProfileOverview extends StatefulWidget {
  @override
  _UserProfileOverviewState createState() => _UserProfileOverviewState();
}

class _UserProfileOverviewState extends State<UserProfileOverview> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _dateController = TextEditingController();
  var _isLoading = false;

  String _userName;
  String _userOccupation;
  DateTime _userBirthdate;

  List<DropdownMenuItem> _occupations = [
    DropdownMenuItem(
      value: 'medico',
      child: Text('Médico(a)'),
    ),
    DropdownMenuItem(
      value: 'enfermeiro',
      child: Text('Enfermeiro(a)'),
    ),
    DropdownMenuItem(
      value: 'farmaceutico',
      child: Text('Farmacêutico(a)'),
    ),
    DropdownMenuItem(
      value: 'estudante',
      child: Text('Estudante'),
    ),
    DropdownMenuItem(
      value: 'outros',
      child: Text('Outros'),
    ),
  ];

  Future<void> _submit() async {
    var isValid = _formKey.currentState.validate();
    FocusScope.of(context).unfocus();

    if (isValid) {
      _formKey.currentState.save();
      setState(() => _isLoading = true);
      await Provider.of<UserPreferences>(context, listen: false)
          .updateUserData(
            name: _userName,
            occupation: _userOccupation,
            birthDate: _userBirthdate,
          )
          .then(
            (value) =>
                Navigator.of(context).pushReplacementNamed('/onboarding'),
          );
    }
  }

  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;
    final titleStyle = TextStyle(color: Colors.white);
    final errorStyle = TextStyle(
      color: Colors.white,
      fontWeight: FontWeight.bold,
    );

    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          height: deviceSize.height,
          width: deviceSize.width,
          decoration: BoxDecoration(
            color: Colors.green,
          ),
          padding: EdgeInsets.symmetric(vertical: 40, horizontal: 40),
          child: _isLoading
              ? Center(
                  child: CircularProgressIndicator(
                    backgroundColor: Colors.white70,
                    valueColor:
                        AlwaysStoppedAnimation<Color>(Colors.green[800]),
                  ),
                )
              : Form(
                  key: _formKey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      // top title
                      Text(
                        'Vamos completar o seu cadastro...',
                        textScaleFactor: 2,
                        style: titleStyle,
                      ),

                      // user input area
                      Column(
                        children: <Widget>[
                          TextFormField(
                            controller: _nameController,
                            decoration: InputDecoration(
                              hintText: 'Nome',
                              errorStyle: errorStyle,
                              fillColor: Colors.white,
                              filled: true,
                              border: OutlineInputBorder(),
                              contentPadding:
                                  EdgeInsets.symmetric(horizontal: 10),
                              icon: Icon(AntDesign.user, color: Colors.white),
                            ),
                            onSaved: (value) => _userName = value,
                          ),
                          SizedBox(height: 10),
                          DropdownButtonFormField(
                            decoration: InputDecoration(
                              errorStyle: errorStyle,
                              fillColor: Colors.white,
                              filled: true,
                              border: OutlineInputBorder(),
                              contentPadding:
                                  EdgeInsets.symmetric(horizontal: 10),
                              icon: Icon(AntDesign.rest, color: Colors.white),
                            ),
                            hint: Text('Ocupação'),
                            items: _occupations,
                            onChanged: (value) {},
                            onSaved: (value) => _userOccupation = value,
                          ),
                          SizedBox(height: 10),
                          TextFormField(
                            controller: _dateController,
                            inputFormatters: [
                              new MaskTextInputFormatter(
                                mask: '##/##/####',
                                filter: {"#": RegExp(r'[0-9]')},
                              ),
                            ],
                            decoration: InputDecoration(
                              hintText: 'Data de Nascimento',
                              errorStyle: errorStyle,
                              fillColor: Colors.white,
                              filled: true,
                              border: OutlineInputBorder(),
                              contentPadding:
                                  EdgeInsets.symmetric(horizontal: 10),
                              icon:
                                  Icon(AntDesign.calendar, color: Colors.white),
                            ),
                            keyboardType: TextInputType.number,
                            onSaved: (value) => _userBirthdate =
                                DateFormat('dd/MM/yyyy').parse(value),
                          ),
                        ],
                      ),
                      RaisedButton(
                        child: Text('Finalizar'),
                        color: Colors.black54,
                        textColor: Colors.white,
                        onPressed: _submit,
                      ),
                    ],
                  ),
                ),
        ),
      ),
    );
  }
}
