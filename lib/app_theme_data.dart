import 'package:flutter/material.dart';

const Color primaryColor = Color.fromARGB(255, 226, 130, 4);
const Color secondaryColor = Color.fromARGB(255, 255, 224, 183);
const Color tertiaryColor = Color.fromARGB(255, 1, 109, 77);
const Color containerColor = Color.fromRGBO(255, 255, 255, 0.85);

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
      );
}
