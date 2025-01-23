import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

const Color primaryColor = Color.fromRGBO(226, 130, 4, 1);
const Color secondaryColor = Color.fromRGBO(255, 224, 183, 1);
const Color tertiaryColor = Color.fromRGBO(0, 65, 45, 1);
const Color containerColor = Color.fromRGBO(255, 255, 255, 0.85);
final TextTheme textTheme = GoogleFonts.lexendDecaTextTheme();

class AppThemeData {
  static ThemeData get theme => ThemeData(
        useMaterial3: true,
        colorScheme: const ColorScheme(
          brightness: Brightness.light,
          primary: primaryColor,
          onPrimary: Colors.white,
          secondary: secondaryColor,
          onSecondary: Colors.black,
          tertiary: tertiaryColor,
          onTertiary: Colors.white,
          error: Colors.red,
          onError: Colors.white,
          surface: containerColor,
          onSurface: Colors.black,
        ),
        appBarTheme: const AppBarTheme(
          backgroundColor: primaryColor,
          foregroundColor: Colors.white,
        ),
        scaffoldBackgroundColor: primaryColor,
        cardTheme: const CardTheme(
          color: containerColor,
          child: ListTile(
            tileColor: containerColor,
          ),
        ),
        menuTheme: const MenuThemeData(
          style: MenuStyle(
            backgroundColor: WidgetStatePropertyAll(containerColor),
          ),
        ),
        dialogTheme: const DialogTheme(
          backgroundColor: containerColor,
        ),
        textTheme: textTheme,
      );
}
