import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:thingz_evignette/constants.dart';

ThemeData lightThemeData(BuildContext context) {
  return ThemeData.light().copyWith(
    primaryColor: primaryColor,
    scaffoldBackgroundColor: contentColorDark,
    iconTheme: IconThemeData(color: contentColorLight),
    textTheme:
        GoogleFonts.montserratTextTheme(Theme.of(context).textTheme).apply(
      bodyColor: contentColorLight,
    ),
    colorScheme: ColorScheme.light(
      primary: primaryColor,
      secondary: secondaryColor,
      background: contentColorLight,
      error: errorColor,
    ),
  );
}

ThemeData darkThemeData(BuildContext context) {
  return ThemeData.dark().copyWith(
    primaryColor: primaryColor,
    scaffoldBackgroundColor: contentColorLight,
    iconTheme: IconThemeData(color: contentColorDark),
    textTheme:
        GoogleFonts.montserratTextTheme(Theme.of(context).textTheme).apply(
      bodyColor: contentColorDark,
    ),
    colorScheme: ColorScheme.dark().copyWith(
      primary: primaryColor,
      secondary: secondaryColor,
      background: contentColorDark,
      error: errorColor,
    ),
  );
}
