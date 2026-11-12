import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mpibrasil/assets.dart';
import 'package:mpibrasil/constants.dart';
import 'package:mpibrasil/generated/l10n.dart';
import 'package:mpibrasil/models/http_exception.dart';
import 'package:mpibrasil/providers/auth_provider.dart';
import 'package:mpibrasil/screens/common/splashscreen.dart';

class ForgotPassword extends StatelessWidget {
  const ForgotPassword({super.key});

  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: kColorMPIWhite,
      body: SingleChildScrollView(
        child: SizedBox(
          height: deviceSize.height,
          width: deviceSize.width,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Flexible(
                flex: deviceSize.width > 600 ? 3 : 2,
                child: ForgotPasswordCard(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class ForgotPasswordCard extends ConsumerStatefulWidget {
  const ForgotPasswordCard({super.key});

  @override
  ConsumerState<ForgotPasswordCard> createState() => _ForgotPasswordCardState();
}

class _ForgotPasswordCardState extends ConsumerState<ForgotPasswordCard> {
  final GlobalKey<FormState> _formKey = GlobalKey();
  bool _isLoading = false;
  String email = '';

  void _showErrorDialog(String message) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(S.current.error),
        content: Padding(
          padding: const EdgeInsets.only(top: 10),
          child: Text(message),
        ),
        actions: <Widget>[
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: Text(S.current.ok),
          ),
        ],
      ),
    );
  }

  Future<void> _submit() async {
    if (!_formKey.currentState!.validate()) return;

    _formKey.currentState!.save();

    setState(() => _isLoading = true);

    try {
      await ref.read(authNotifierProvider.notifier).forgotPassword(email);

      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(S.current.forgotPasswordRequestSent)),
      );

      Navigator.of(context).pop();
    } on HttpException catch (error) {
      if (!mounted) return;

      final errorMessage = error.message == 'EMAIL_NOT_FOUND'
          ? S.current.forgotPasswordErrorEmailNotFound
          : S.current.forgotPasswordErrorGeneric;

      _showErrorDialog(errorMessage);
    } catch (error) {
      if (!mounted) return;

      _showErrorDialog(S.current.errorUnexpected(error));
    } finally {
      if (mounted) {
        setState(() => _isLoading = false);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final titleStyle = TextStyle(
      color: kColorMPIGray,
      fontSize: 22,
      fontWeight: FontWeight.bold,
    );

    final messageStyle = TextStyle(color: kColorMPIGray, fontSize: 18);

    return _isLoading
        ? SplashScreen()
        : Container(
            padding: const EdgeInsets.all(35.0),
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Image.asset(
                    MpiAssets.imgUndrawAccountAmico,
                    height: 256,
                    width: 256,
                  ),
                  Text(S.current.forgotPasswordPageTitle, style: titleStyle),
                  const SizedBox(height: 10),
                  Text(
                    S.current.forgotPasswordPageBody,
                    style: messageStyle,
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 5),
                  TextFormField(
                    keyboardType: TextInputType.emailAddress,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: S.current.forgotPasswordEmailHintText,
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: 10,
                      ),
                    ),
                    validator: (value) {
                      if (value == null ||
                          value.isEmpty ||
                          !value.contains('@')) {
                        return S.current.forgotPasswordErrorInvalidEmail;
                      }
                      return null;
                    },
                    onSaved: (value) => email = value ?? '',
                  ),
                  const SizedBox(height: 20),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: <Widget>[
                      ElevatedButton(
                        onPressed: _submit,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: kColorMPIGreen,
                        ),
                        child: Text(
                          S.current.forgotPasswordPageButtonSubmit,
                          style: TextStyle(color: kColorMPIWhite),
                        ),
                      ),
                      const SizedBox(height: 10),
                      InkWell(
                        onTap: () => Navigator.of(context).pop(),
                        child: Text(
                          S.current.forgotPasswordPageLabelBackToLogin,
                          textAlign: TextAlign.center,
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          );
  }
}
