import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  static const Color primaryColor = Color(0xFF6C63FF);
  static const Color secondaryColor = Color(0xFFFFB84D);
  static const Color pinkColor = Color(0xFFFF7AA2);
  static const Color skyColor = Color(0xFF7DD3FC);
  static const Color mintColor = Color(0xFF86EFAC);
  static const Color backgroundColor = Color(0xFFFDFBFF);
  static const Color cardColor = Colors.white;
  static const Color textDark = Color(0xFF2D3142);

  static ThemeData get lightTheme {
    return ThemeData(
      useMaterial3: true,
      scaffoldBackgroundColor: backgroundColor,
      textTheme: GoogleFonts.nunitoTextTheme().apply(
        bodyColor: textDark,
        displayColor: textDark,
      ),
      colorScheme: ColorScheme.fromSeed(
        seedColor: primaryColor,
        background: backgroundColor,
      ),
      appBarTheme: AppBarTheme(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        titleTextStyle: GoogleFonts.nunito(
          fontSize: 24,
          fontWeight: FontWeight.w800,
          color: textDark,
        ),
      ),
    );
  }
}