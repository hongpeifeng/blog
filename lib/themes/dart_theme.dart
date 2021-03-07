

import 'package:blog/themes/colors.dart';
import 'package:blog/themes/utils.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

final ThemeData base = ThemeData.dark();
final ThemeData darkTheme = base.copyWith(
  accentColor: BlogColors.orange300,
  bottomAppBarColor: BlogColors.darkBottomAppBarBackground,
  bottomSheetTheme: BottomSheetThemeData(
    backgroundColor: BlogColors.darkDrawerBackground,
    modalBackgroundColor: Colors.black.withOpacity(0.7),
  ),
  navigationRailTheme: NavigationRailThemeData(
    backgroundColor: BlogColors.darkBottomAppBarBackground,
    selectedIconTheme: const IconThemeData(color: BlogColors.orange300),
    selectedLabelTextStyle:
    GoogleFonts.workSansTextTheme().headline5.copyWith(
      color: BlogColors.orange300,
    ),
    unselectedIconTheme: const IconThemeData(color: BlogColors.greyLabel),
    unselectedLabelTextStyle:
    GoogleFonts.workSansTextTheme().headline5.copyWith(
      color: BlogColors.greyLabel,
    ),
  ),
  canvasColor: BlogColors.black900,
  cardColor: BlogColors.darkCardBackground,
  chipTheme: buildChipTheme(
    BlogColors.blue200,
    BlogColors.darkChipBackground,
    Brightness.dark,
  ),
  colorScheme: const ColorScheme.dark(
    primary: BlogColors.blue200,
    primaryVariant: BlogColors.blue300,
    secondary: BlogColors.orange300,
    secondaryVariant: BlogColors.orange300,
    surface: BlogColors.black800,
    error: BlogColors.red200,
    onPrimary: BlogColors.black900,
    onSecondary: BlogColors.black900,
    onBackground: BlogColors.white50,
    onSurface: BlogColors.white50,
    onError: BlogColors.black900,
    background: BlogColors.black900Alpha087,
  ),
  textTheme: _buildReplyDarkTextTheme(base.textTheme),
  scaffoldBackgroundColor: BlogColors.black900,
);


TextTheme _buildReplyDarkTextTheme(TextTheme base) {
  return base.copyWith(
    headline4: GoogleFonts.workSans(
      fontWeight: FontWeight.w600,
      fontSize: 34,
      letterSpacing: letterSpacingOrNone(0.4),
      height: 0.9,
      color: BlogColors.white50,
    ),
    headline5: GoogleFonts.workSans(
      fontWeight: FontWeight.bold,
      fontSize: 24,
      letterSpacing: letterSpacingOrNone(0.27),
      color: BlogColors.white50,
    ),
    headline6: GoogleFonts.workSans(
      fontWeight: FontWeight.w600,
      fontSize: 20,
      letterSpacing: letterSpacingOrNone(0.18),
      color: BlogColors.white50,
    ),
    subtitle2: GoogleFonts.workSans(
      fontWeight: FontWeight.w600,
      fontSize: 14,
      letterSpacing: letterSpacingOrNone(-0.04),
      color: BlogColors.white50,
    ),
    bodyText1: GoogleFonts.workSans(
      fontWeight: FontWeight.normal,
      fontSize: 18,
      letterSpacing: letterSpacingOrNone(0.2),
      color: BlogColors.white50,
    ),
    bodyText2: GoogleFonts.workSans(
      fontWeight: FontWeight.normal,
      fontSize: 14,
      letterSpacing: letterSpacingOrNone(-0.05),
      color: BlogColors.white50,
    ),
    caption: GoogleFonts.workSans(
      fontWeight: FontWeight.normal,
      fontSize: 12,
      letterSpacing: letterSpacingOrNone(0.2),
      color: BlogColors.white50,
    ),
  );
}