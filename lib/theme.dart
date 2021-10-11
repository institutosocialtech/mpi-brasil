import 'package:flutter/material.dart';
import 'constants.dart';

final _inputBorder = OutlineInputBorder(
  borderSide: BorderSide(color: kInputBorderColor),
  borderRadius: BorderRadius.circular(kInputBorderRadius),
  gapPadding: 4,
);

final _elevatedButtonStyle = ElevatedButton.styleFrom(
  shape: RoundedRectangleBorder(
    borderRadius: BorderRadius.circular(kButtonBorderRadius),
  ),
);

final ThemeData appTheme = ThemeData(
  // app colors
  primarySwatch: MaterialColor(4285313822, {
    50: Color(0xfff3fbe9),
    100: Color(0xffe6f8d3),
    200: Color(0xffcef0a8),
    300: Color(0xffb5e97c),
    400: Color(0xff9ce250),
    500: Color(0xff84da25),
    600: Color(0xff69af1d),
    700: Color(0xff4f8316),
    800: Color(0xff35570f),
    900: Color(0xff1a2c07)
  }),

  // primary and accent colors
  brightness: Brightness.light,
  primaryColor: kColorMPIGreen,
  primaryColorBrightness: Brightness.light,
  accentColor: kColorMPIGreenOpaque,
  accentColorBrightness: Brightness.light,

  // component colors
  dividerColor: Colors.transparent,
  scaffoldBackgroundColor: kColorMPIWhite,

  // font
  fontFamily: 'Nunito',

  // app bar
  appBarTheme: AppBarTheme(
    elevation: 0,
    centerTitle: false,
    color: kColorMPIWhite,
  ),

  elevatedButtonTheme: ElevatedButtonThemeData(style: _elevatedButtonStyle),

  // input decoration
  inputDecorationTheme: InputDecorationTheme(
    filled: true,
    fillColor: Color(0xFFFFFFF),
    focusColor: Color(0xFFFFFFF),
    // content padding
    contentPadding: EdgeInsets.all(kInputContentPadding),
    // input border settings
    border: _inputBorder,
    disabledBorder: _inputBorder,
    errorBorder: _inputBorder,
    enabledBorder: _inputBorder,
    focusedBorder: _inputBorder,
    focusedErrorBorder: _inputBorder,
    // label colors
    labelStyle: TextStyle(color: kColorMPIGray),
    hintStyle: TextStyle(color: kColorMPIGray),
  ),
);
