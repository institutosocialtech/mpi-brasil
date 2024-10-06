import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:mpibrasil/constants.dart';
import 'package:mpibrasil/generated/l10n.dart';
import 'package:mpibrasil/providers/userpreferences.dart';
import 'package:provider/provider.dart';

class UserProfileOverview extends StatefulWidget {
  @override
  _UserProfileOverviewState createState() => _UserProfileOverviewState();
}

class _UserProfileOverviewState extends State<UserProfileOverview> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _dateController = TextEditingController();
  var _isLoading = false;
  var _isInit = true;

  String? _userName;
  String? _userOccupation;
  DateTime? _userBirthdate;

  String? _validateBirthDate(String? value) {
    // return error message if input is empty
    if (value?.isEmpty ?? true) return S.current.profileSetupBirthDateErrorText;

    try {
      final date = DateFormat('dd/MM/yyyy').parse(value!);
      // return error message if date is in the future or before 1900
      if (date.isAfter(DateTime.now()) || date.isBefore(DateTime(1900))) {
        return S.current.profileSetupBirthDateErrorText;
      }
    } catch (e) {
      // return error message if date is not in the correct format
      return S.current.profileSetupBirthDateErrorText;
    }

    return null;
  }

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

  // todo: validate name input as chars only
  Future<void> _submit() async {
    var isValid = _formKey.currentState!.validate();
    FocusScope.of(context).unfocus();

    if (isValid) {
      _formKey.currentState!.save();
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

    var userData = Provider.of<UserPreferences>(context, listen: false);
    var user = userData.user;

    if (user.occupation?.isNotEmpty ?? false) {
      _userOccupation = user.occupation;
    }

    _nameController.text = user.name ?? '';
    _dateController.text = user.birthDate != null
        ? DateFormat('dd/MM/yyyy').format(user.birthDate!)
        : '';

    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          height: deviceSize.height,
          width: deviceSize.width,
          decoration: BoxDecoration(
            color: kColorMPIGreen,
          ),
          padding: EdgeInsets.symmetric(vertical: 40, horizontal: 40),
          child: _isLoading
              ? Center(
                  child: CircularProgressIndicator(
                    backgroundColor: kColorMPIWhite,
                    valueColor: AlwaysStoppedAnimation<Color>(kColorMPIGreen),
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
                        S.current.profileSetupHeader,
                        textScaleFactor: 2,
                        style: titleStyle,
                      ),

                      // user input area
                      Column(
                        children: <Widget>[
                          TextFormField(
                            controller: _nameController,
                            decoration: InputDecoration(
                              hintText: S.current.profileSetupNameHintText,
                              errorStyle: errorStyle,
                              fillColor: kColorMPIWhite,
                              filled: true,
                              border: OutlineInputBorder(),
                              contentPadding:
                                  EdgeInsets.symmetric(horizontal: 10),
                              icon: Icon(Icons.person, color: kColorMPIWhite),
                            ),
                            onSaved: (value) => _userName = value,
                            validator: (value) => value?.isEmpty ?? true
                                ? S.current.profileSetupNameErrorText
                                : null,
                          ),
                          SizedBox(height: 10),
                          DropdownButtonFormField(
                            value: _userOccupation,
                            decoration: InputDecoration(
                              errorStyle: errorStyle,
                              fillColor: kColorMPIWhite,
                              filled: true,
                              border: OutlineInputBorder(),
                              contentPadding:
                                  EdgeInsets.symmetric(horizontal: 10),
                              icon: Icon(Icons.work, color: kColorMPIWhite),
                            ),
                            hint:
                                Text(S.current.profileSetupOccupationHintText),
                            items: _dropdownItems,
                            onChanged: (value) {},
                            onSaved: (value) =>
                                _userOccupation = value.toString(),
                            validator: (value) => value?.isEmpty ?? true
                                ? S.current.profileSetupOccupationErrorText
                                : null,
                          ),
                          SizedBox(height: 10),

                          // todo: validate date format
                          TextFormField(
                            controller: _dateController,
                            inputFormatters: [
                              new MaskTextInputFormatter(
                                mask: '##/##/####',
                                filter: {"#": RegExp(r'[0-9]')},
                              ),
                            ],
                            decoration: InputDecoration(
                              hintText: S.current.profileSetupBirthDateHintText,
                              errorStyle: errorStyle,
                              fillColor: kColorMPIWhite,
                              filled: true,
                              border: OutlineInputBorder(),
                              contentPadding:
                                  EdgeInsets.symmetric(horizontal: 10),
                              icon: Icon(Icons.calendar_today,
                                  color: kColorMPIWhite),
                            ),
                            keyboardType: TextInputType.number,
                            validator: (value) => _validateBirthDate(value),
                            onSaved: (value) => _userBirthdate =
                                DateFormat('dd/MM/yyyy').parse(value!),
                          ),
                        ],
                      ),
                      ElevatedButton(
                        onPressed: _submit,
                        child: Text(
                          S.current.profileSetupSubmitButtonText,
                          style: TextStyle(color: kColorMPIGreen),
                        ),
                        style: ElevatedButton.styleFrom(
                          foregroundColor: kColorMPIWhite,
                        ),
                      ),
                    ],
                  ),
                ),
        ),
      ),
    );
  }

  List<DropdownMenuItem> get _dropdownItems {
    final _occupations = {
      'medico': S.current.jobDoctor,
      'enfermeiro': S.current.jobNurse,
      'farmaceutico': S.current.jobPharmacist,
      'estudante': S.current.jobStudent,
      'outros': S.current.jobOther,
    };

    return _occupations.entries
        .map((entry) =>
            DropdownMenuItem(value: entry.key, child: Text(entry.value)))
        .toList();
  }
}
