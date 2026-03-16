import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  // Breakpoints
  static const double bpMobile = 600;
  static const double bpTablet = 1024;
  static const double maxContentWidth = 1200;

  // Colors
  static const navy = Color(0xFF0A1628);
  static const navyMid = Color(0xFF112240);
  static const navyLight = Color(0xFF1C3461);
  static const teal = Color(0xFF00B4D8);
  static const tealSoft = Color(0xFF0096B7);
  static const gold = Color(0xFFC9A84C);
  static const goldLight = Color(0xFFE2C47A);
  static const white = Color(0xFFF4F7FC);
  static const muted = Color(0xFF8A9BB5);
  static const cardBg = Color(0xFF0F1E36);
  static const borderColor = Color(0x2600B4D8);
  static const green = Color(0xFF4DFFA4);

  static ThemeData get theme => ThemeData(
        useMaterial3: true,
        scaffoldBackgroundColor: navy,
        colorScheme: const ColorScheme.dark(
          primary: teal,
          secondary: gold,
          surface: cardBg,
        ),
        textTheme: GoogleFonts.dmSansTextTheme(
          const TextTheme(
            bodyMedium: TextStyle(color: white),
          ),
        ),
      );

  // Text Styles
  static TextStyle playfair({
    double size = 16,
    FontWeight weight = FontWeight.w700,
    Color color = white,
    double? height,
    double letterSpacing = 0,
  }) =>
      GoogleFonts.playfairDisplay(
        fontSize: size,
        fontWeight: weight,
        color: color,
        height: height,
        letterSpacing: letterSpacing,
      );

  static TextStyle dmSans({
    double size = 14,
    FontWeight weight = FontWeight.w400,
    Color color = white,
    double? height,
    double letterSpacing = 0,
  }) =>
      GoogleFonts.dmSans(
        fontSize: size,
        fontWeight: weight,
        color: color,
        height: height,
        letterSpacing: letterSpacing,
      );

  static TextStyle dmMono({
    double size = 12,
    FontWeight weight = FontWeight.w400,
    Color color = muted,
    double letterSpacing = 0,
  }) =>
      GoogleFonts.dmMono(
        fontSize: size,
        fontWeight: weight,
        color: color,
        letterSpacing: letterSpacing,
      );
}
