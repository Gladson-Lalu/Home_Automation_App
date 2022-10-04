import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'colors.dart';

class AppTheme {
  static final lightTheme = ThemeData(
    cardColor: lightContainerBG,
    primaryColor: lightPrimaryColor,
    backgroundColor: lightScaffoldBG,
    colorScheme: const ColorScheme.dark(
        secondary: lightSecondaryColor),
    textTheme: TextTheme(
      labelMedium:
          GoogleFonts.oswald(color: lightContainerText),
      subtitle2: GoogleFonts.sourceSansPro(
        color: lightContainerText,
      ),
      headline6: GoogleFonts.roboto(
          color: lightTitlecolor,
          fontWeight: FontWeight.w600),
      bodyText1: const TextStyle(color: lightTextcolor),
      bodyText2: const TextStyle(color: lightTextcolor),
    ),
  );

  //dark theme
  static final darkTheme = ThemeData(
    primaryColor: darkPrimarycolor,
    backgroundColor: darkScaffoldBG,
    cardColor: darkContainerBG,
    colorScheme:
        const ColorScheme.dark(secondary: darkSecondaryBG),
    textTheme: TextTheme(
      labelMedium:
          GoogleFonts.oswald(color: darkContainerText),
      subtitle2: GoogleFonts.sourceSansPro(
        color: darkContainerText,
      ),
      headline6: GoogleFonts.roboto(
          color: darkTitlecolor,
          fontWeight: FontWeight.w600),
      bodyText1: const TextStyle(color: darkTextcolor),
      bodyText2: const TextStyle(color: darkTextcolor),
    ),
  );
}
