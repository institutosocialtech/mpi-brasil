import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:mpibrasil/constants.dart';
import 'package:mpibrasil/extensions.dart';
import 'package:mpibrasil/generated/l10n.dart';
import 'package:mpibrasil/providers/auth.dart';
import 'package:mpibrasil/providers/userpreferences.dart';
import 'package:provider/provider.dart';

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
        title: Text(S.current.settingsAppBarTitle),
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
                    child: Text(S.current.settingsLogout),
                    onPressed: () {
                      Navigator.pop(context);
                      Navigator.pushReplacementNamed(context, '/');
                      Provider.of<Auth>(context, listen: false).logout();
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: kColorMPIGreen,
                      foregroundColor: kColorMPIWhite,
                    ),
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
            title: Text(S.current.settingsNameTileTitle),
            subtitle: Text(user.name ?? ''),
            leading: Icon(Icons.person, color: kColorMPIGreen),
            trailing: IconButton(
              icon: Icon(Icons.edit),
              onPressed: () => _showEditNameDialog(context, user.name ?? ''),
            ),
          ),

          // user email
          // TODO: implement email change
          Visibility(
            visible: false,
            child: ListTile(
              enabled: false,
              title: Text(S.current.settingsEmailTileTitle),
              subtitle: Text(S.current.socialTechEmail),
              leading: Icon(Icons.email, color: kColorMPIGreen),
              trailing: IconButton(
                icon: Icon(Icons.edit),
                onPressed: () {},
              ),
            ),
          ),

          // user password
          // TODO: implement password change
          Visibility(
            visible: false,
            child: ListTile(
              enabled: false,
              title: Text(S.current.settingsPasswordTileTitle),
              subtitle: Text(S.current.settingsPasswordTileSubtitle),
              leading: Icon(Icons.key, color: kColorMPIGreen),
              trailing: IconButton(
                icon: Icon(Icons.edit),
                onPressed: () {},
              ),
            ),
          ),

          // user birthDate
          ListTile(
            title: Text(S.current.settingsBirthDateTileTitle),
            subtitle: Text(user.birthDate?.formattedDate ?? ''),
            leading: Icon(Icons.calendar_today, color: kColorMPIGreen),
            trailing: IconButton(
              icon: Icon(Icons.edit),
              onPressed: () => _showEditBirthDateDialog(
                context,
                user.birthDate?.formattedDate ?? '',
              ),
            ),
          ),

          // user occupation
          ListTile(
            title: Text(S.current.settingsOccupationTileTitle),
            subtitle: Text(user.occupationString),
            leading: Icon(Icons.work, color: kColorMPIGreen),
            trailing: IconButton(
              icon: Icon(Icons.edit),
              onPressed: () =>
                  _showEditOccupationDialog(context, user.occupationString),
            ),
          ),

          // delete account
          ListTile(
            title: Text(S.current.settingsRedactUserTileTitle),
            subtitle: Text(S.current.settingsRedactUserTileSubtitle),
            leading: Icon(Icons.delete_forever, color: kColorMPIGreen),
            onTap: () => Navigator.of(context).pushNamed('/delete_account'),
          ),
        ],
      ),
    );
  }

  Future<void> _showEditNameDialog(
    BuildContext context,
    String initialValue,
  ) async {
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
          title: Text(S.current.editNameDialogTitle),
          content: Container(
            width: deviceSize.width * 0.85,
            margin: EdgeInsets.symmetric(vertical: 20),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                TextField(
                  controller: controller,
                  decoration: InputDecoration(
                    hintText: S.current.editNameTextFieldHintText,
                    labelText: S.current.editNameTextFieldLabelText,
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
              child: Text(S.current.editNameDialogCancel),
              style: TextButton.styleFrom(
                foregroundColor: kColorMPIGreen,
              ),
            ),

            // save action
            TextButton(
              onPressed: () => Navigator.of(context).pop(controller.text),
              child: Text(S.current.editNameDialogSave),
              style: TextButton.styleFrom(
                foregroundColor: kColorMPIWhite,
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
    BuildContext context,
    String initialValue,
  ) async {
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
          title: Text(S.current.editBirthDateDialogTitle),
          content: Container(
            width: deviceSize.width * 0.85,
            margin: EdgeInsets.symmetric(vertical: 20),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                TextField(
                  controller: controller,
                  inputFormatters: [
                    // todo validate date input
                    new MaskTextInputFormatter(
                      mask: '##/##/####',
                      filter: {"#": RegExp(r'[0-9]')},
                    ),
                  ],
                  decoration: InputDecoration(
                    hintText: S.current.editBirthDateTextFieldHintText,
                    labelText: S.current.editBirthDateTextFieldLabelText,
                    border: OutlineInputBorder(),
                    contentPadding: EdgeInsets.symmetric(horizontal: 10),
                  ),
                ),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text(S.current.editBirthDateDialogCancel),
              style: TextButton.styleFrom(foregroundColor: kColorMPIGreen),
            ),
            TextButton(
              onPressed: () => Navigator.of(context).pop(
                DateFormat('dd/MM/yyyy').parse(controller.text),
              ),
              child: Text(S.current.editBirthDateDialogSave),
              style: TextButton.styleFrom(
                foregroundColor: kColorMPIWhite,
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
    BuildContext context,
    String initialValue,
  ) async {
    final deviceSize = MediaQuery.of(context).size;

    var update = await showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        String? selected =
            Provider.of<UserPreferences>(context).user.occupation;

        final occupations = {
          'medico': S.current.jobDoctor,
          'enfermeiro': S.current.jobNurse,
          'estudante': S.current.jobStudent,
          'farmaceutico': S.current.jobPharmacist,
          'outros': S.current.jobOther,
        };

        final dropDownItems = occupations.entries
            .map((entry) => DropdownMenuItem(
                  child: Text(entry.value),
                  value: entry.key,
                ))
            .toList();

        // build dialog
        return AlertDialog(
          title: Text(S.current.editOccupationDialogTitle),
          content: StatefulBuilder(
            builder: (context, setState) {
              return Container(
                width: deviceSize.width * 0.75,
                child: DropdownButton(
                  onChanged: (value) => setState(() => selected = value),
                  isExpanded: true,
                  value: selected,
                  items: dropDownItems,
                ),
              );
            },
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text(S.current.editOccupationDialogCancel),
              style: TextButton.styleFrom(
                foregroundColor: kColorMPIGreenOpaque,
              ),
            ),
            TextButton(
              onPressed: () => Navigator.of(context).pop(selected),
              child: Text(S.current.editOccupationDialogSave),
              style: TextButton.styleFrom(
                foregroundColor: kColorMPIWhite,
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
}
