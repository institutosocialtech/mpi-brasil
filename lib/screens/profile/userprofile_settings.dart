import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:mpibrasil/constants.dart';
import 'package:mpibrasil/extensions.dart';
import 'package:mpibrasil/generated/l10n.dart';
import 'package:mpibrasil/providers/auth_provider.dart';
import 'package:mpibrasil/providers/user_preferences_provider.dart';

class ProfileSettings extends ConsumerStatefulWidget {
  @override
  ConsumerState<ProfileSettings> createState() => _ProfileSettingsState();
}

class _ProfileSettingsState extends ConsumerState<ProfileSettings> {
  var _isLoading = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _fetchUserData();
    });
  }

  Future<void> _fetchUserData() async {
    setState(() => _isLoading = true);
    await ref.read(userPreferencesNotifierProvider.notifier).fetchUserData();
    if (mounted) {
      setState(() => _isLoading = false);
    }
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
                  _drawSettingsCard(context),
                  ElevatedButton(
                    child: Text(S.current.settingsLogout),
                    onPressed: () async {
                      await ref.read(authNotifierProvider.notifier).logout();
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

  Widget _drawSettingsCard(BuildContext context) {
    final user = ref.watch(userPreferencesNotifierProvider);

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
      ref.read(userPreferencesNotifierProvider.notifier)
          .updateUserData(name: update);
    }
  }

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
                TextFormField(
                  controller: controller,
                  inputFormatters: [
                    // todo validate date input
                    MaskTextInputFormatter(
                      mask: '##/##/####',
                      filter: {"#": RegExp(r'[0-9]')},
                    ),
                  ],
                  // todo validate date input
                  validator: _validateBirthDate,
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
      ref.read(userPreferencesNotifierProvider.notifier)
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
      builder: (dialogContext) {
        String? selected = ref.read(userPreferencesNotifierProvider).occupation;

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
              onPressed: () => Navigator.of(dialogContext).pop(),
              child: Text(S.current.editOccupationDialogCancel),
              style: TextButton.styleFrom(
                foregroundColor: kColorMPIGreenOpaque,
              ),
            ),
            TextButton(
              onPressed: () => Navigator.of(dialogContext).pop(selected),
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
      ref.read(userPreferencesNotifierProvider.notifier)
          .updateUserData(occupation: update);
    }
  }
}
