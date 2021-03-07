

import 'package:blog/themes/colors.dart';
import 'package:blog/themes/utils.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

final ThemeData base = ThemeData.light();
final ThemeData lightTheme = base.copyWith(
  accentColor: BlogColors.orange500,
  bottomAppBarColor: BlogColors.blue700,
  bottomSheetTheme: BottomSheetThemeData(
    backgroundColor: BlogColors.blue700,
    modalBackgroundColor: Colors.white.withOpacity(0.7),
  ),
  navigationRailTheme: NavigationRailThemeData(
    backgroundColor: BlogColors.blue700,
    selectedIconTheme: const IconThemeData(color: BlogColors.orange500),
    selectedLabelTextStyle:
    GoogleFonts.workSansTextTheme().headline5.copyWith(
      color: BlogColors.orange500,
    ),
    unselectedIconTheme: const IconThemeData(color: BlogColors.blue200),
    unselectedLabelTextStyle:
    GoogleFonts.workSansTextTheme().headline5.copyWith(
      color: BlogColors.blue200,
    ),
  ),
  chipTheme: buildChipTheme(
    BlogColors.blue700,
    BlogColors.lightChipBackground,
    Brightness.light,
  ),
  canvasColor: BlogColors.white50,
  cardColor: BlogColors.white50,
  colorScheme: const ColorScheme.light(
    primary: BlogColors.blue700,
    primaryVariant: BlogColors.blue800,
    secondary: BlogColors.orange500,
    secondaryVariant: BlogColors.orange400,
    surface: BlogColors.white50,
    error: BlogColors.red400,
    onPrimary: BlogColors.white50,
    onSecondary: BlogColors.black900,
    onBackground: BlogColors.black900,
    onSurface: BlogColors.black900,
    onError: BlogColors.black900,
    background: BlogColors.blue50,
  ),
  textTheme: _buildReplyLightTextTheme(base.textTheme),
  scaffoldBackgroundColor: BlogColors.blue50,
);


TextTheme _buildReplyLightTextTheme(TextTheme base) {
  return base.copyWith(
    headline4: GoogleFonts.workSans(
      fontWeight: FontWeight.w600,
      fontSize: 34,
      letterSpacing: letterSpacingOrNone(0.4),
      height: 0.9,
      color: BlogColors.black900,
    ),
    headline5: GoogleFonts.workSans(
      fontWeight: FontWeight.bold,
      fontSize: 24,
      letterSpacing: letterSpacingOrNone(0.27),
      color: BlogColors.black900,
    ),
    headline6: GoogleFonts.workSans(
      fontWeight: FontWeight.w600,
      fontSize: 20,
      letterSpacing: letterSpacingOrNone(0.18),
      color: BlogColors.black900,
    ),
    subtitle2: GoogleFonts.workSans(
      fontWeight: FontWeight.w600,
      fontSize: 14,
      letterSpacing: letterSpacingOrNone(-0.04),
      color: BlogColors.black900,
    ),
    bodyText1: GoogleFonts.workSans(
      fontWeight: FontWeight.normal,
      fontSize: 18,
      letterSpacing: letterSpacingOrNone(0.2),
      color: BlogColors.black900,
    ),
    bodyText2: GoogleFonts.workSans(
      fontWeight: FontWeight.normal,
      fontSize: 14,
      letterSpacing: letterSpacingOrNone(-0.05),
      color: BlogColors.black900,
    ),
    caption: GoogleFonts.workSans(
      fontWeight: FontWeight.normal,
      fontSize: 12,
      letterSpacing: letterSpacingOrNone(0.2),
      color: BlogColors.black900,
    ),
  );
}
