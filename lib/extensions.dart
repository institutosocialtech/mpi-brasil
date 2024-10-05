import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

/// add localization strings to build context
extension AppLocalizationsX on BuildContext {
  AppLocalizations get l10n => AppLocalizations.of(this)!;
}

extension DateTimeX on DateTime {
  String get formattedDate => '${this.day}/${this.month}/${this.year}';
}
